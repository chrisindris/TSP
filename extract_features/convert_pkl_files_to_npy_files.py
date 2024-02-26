from __future__ import division, print_function

import argparse
import pickle as pkl
import h5py
import glob
import os
from pathlib import Path
import numpy as np

from tqdm import tqdm


def main(args):
    print(args)
    filenames = glob.glob(os.path.join(args.features_folder, "*.pkl"))
    print(f"Number of pkl files: {len(filenames)}")

    Path(args.output_folder).mkdir(parents=True, exist_ok=True)

    for f in tqdm(filenames):
        video_name = os.path.basename(f).split(".pkl")[0]
        output_f = os.path.join(args.output_folder, video_name + ".npy")

        data = pkl.load(open(f, "rb"))
        np.save(output_f, data)

        print(output_f)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        description="Merge the feature pkl files of different videos into one "
        "h5 feature file mapping video name to feature tensor."
    )

    parser.add_argument(
        "--features-folder",
        required=True,
        type=str,
        help="Path to the folder containing the pkl feature files",
    )
    parser.add_argument(
        "--output-folder",
        required=True,
        type=str,
        help="Where to save the combined metadata CSV file",
    )

    args = parser.parse_args()

    main(args)
