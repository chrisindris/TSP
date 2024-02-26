# Converts the h5py files given by https://github.com/HumamAlwassel/TSP into the standard directory of .npy that ActionFormer prefers.
# TODO: in future, these features should be incorporated into the pipeline rather than ran manually/separately.

import argparse
import os
import h5py
import numpy as np


def argument_parser():
    parser = argparse.ArgumentParser(
        description="Process some .npz files in a directory."
    )
    parser.add_argument(
        "--input_file",
        type=str,
        help="the h5py file",
    )
    parser.add_argument(
        "--output_feature_dir",
        type=str,
        help="directory for where to store the .npy features",
    )
    return parser


def main(args):
    os.makedirs(args.output_feature_dir, exist_ok=True)
    f = h5py.File(args.input_file, "r")

    for v in f.keys():
        out_path = os.path.join(args.output_feature_dir, v + ".npy")
        np.save(out_path, np.array(f[v]))


if __name__ == "__main__":
    parser = argument_parser()
    args = parser.parse_args()
    main(args)
