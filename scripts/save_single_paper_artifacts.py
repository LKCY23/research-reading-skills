#!/usr/bin/env python3
import argparse
import json
import shutil
from datetime import datetime, timezone
from pathlib import Path

REQUIRED_ROOT_FILES = [
    "README.md",
    "input-metadata.json",
    "source-excerpts.md",
]

REQUIRED_ARTIFACT_FILES = [
    "quick-pass.json",
    "method-card.json",
    "experiment-card.json",
    "claim-evidence-table.json",
    "limitations-card.json",
    "repro-notes.json",
    "critical-read-notes.json",
    "project-relevance.json",
    "uncertainty-summary.json",
    "paper-card.json",
    "paper-card.md",
]


def validate_source_dir(source_dir: Path) -> None:
    missing = []
    for name in REQUIRED_ROOT_FILES:
        if not (source_dir / name).is_file():
            missing.append(name)

    artifacts_dir = source_dir / "artifacts"
    if not artifacts_dir.is_dir():
        missing.append("artifacts/")
    else:
        for name in REQUIRED_ARTIFACT_FILES:
            if not (artifacts_dir / name).is_file():
                missing.append(f"artifacts/{name}")

    if missing:
        joined = "\n- ".join(missing)
        raise SystemExit(f"Source artifact set is incomplete. Missing:\n- {joined}")


def copy_file(src: Path, dst: Path) -> None:
    dst.parent.mkdir(parents=True, exist_ok=True)
    shutil.copy2(src, dst)


def write_saved_run_manifest(source_dir: Path, dest_dir: Path, paper_id: str) -> None:
    artifact_files = [
        "input-metadata.json",
        "source-excerpts.md",
        *[f"artifacts/{name}" for name in REQUIRED_ARTIFACT_FILES],
    ]

    payload = {
        "paper_id": paper_id,
        "saved_at": datetime.now(timezone.utc).replace(microsecond=0).isoformat().replace("+00:00", "Z"),
        "saved_from": str(source_dir.relative_to(REPO_ROOT)),
        "library_path": str(dest_dir.relative_to(REPO_ROOT)),
        "artifact_files": artifact_files,
    }

    (dest_dir / "saved-run.json").write_text(json.dumps(payload, indent=2) + "\n", encoding="utf-8")


def main() -> None:
    parser = argparse.ArgumentParser(description="Copy a completed single-paper artifact set into library/single-paper/<paper-id>/.")
    parser.add_argument("--source", required=True, help="Path to a completed single-paper artifact directory.")
    parser.add_argument("--paper-id", required=True, help="Stable paper slug used for the library destination.")
    parser.add_argument("--overwrite", action="store_true", help="Allow overwriting an existing library destination.")
    args = parser.parse_args()

    source_dir = Path(args.source).resolve()
    if not source_dir.is_dir():
        raise SystemExit(f"Source directory does not exist: {source_dir}")

    validate_source_dir(source_dir)

    dest_dir = (REPO_ROOT / "library" / "single-paper" / args.paper_id).resolve()
    if dest_dir.exists():
        if not args.overwrite:
            raise SystemExit(f"Destination already exists: {dest_dir}\nUse --overwrite to replace it.")
        shutil.rmtree(dest_dir)

    dest_dir.mkdir(parents=True, exist_ok=True)

    for name in REQUIRED_ROOT_FILES:
        copy_file(source_dir / name, dest_dir / name)

    for name in REQUIRED_ARTIFACT_FILES:
        copy_file(source_dir / "artifacts" / name, dest_dir / "artifacts" / name)

    write_saved_run_manifest(source_dir, dest_dir, args.paper_id)
    print(dest_dir)


REPO_ROOT = Path(__file__).resolve().parent.parent

if __name__ == "__main__":
    main()
