from setuptools import setup, find_packages

# Note: This package is still under the context_general_bci namespace, same as the codebase it inherited (https://github.com/joel99/context_general_bci)
# Thus installing both packages will lead to namespace conflicts.
# Presuming this is fine b/c NDT3 essentially deprecates NDT2 in terms of results.

# Switching is currently onerous because preprocessed data is locked to the `context_general_bci` namespace.
setup(
    name='context_general_bci',
    version='0.1.0',

    url='https://github.com/joel99/ndt3',
    author='Joel Ye',
    author_email='joelye9@gmail.com',
    description='NDT3 pretraining and analysis monorepo',
    packages=find_packages(exclude=['scripts', 'crc_scripts', 'data', 'data_scripts', 'slurm']),
    py_modules=['context_general_bci'],

    install_requires=[
        'torch>=2.0.0',  # Compatible with modern Python versions
        'torchvision>=0.15.0',
        'seaborn',
        'pandas',
        'numpy<2.0',  # NumPy 2.x causes binary incompatibility issues
        'scipy',
        # 'onnxruntime-gpu',
        'pyrtma',
        'hydra-core',
        'yacs',
        'pynwb',
        'argparse',
        'wandb',
        'einops',
        'lightning>=2.0',
        'scikit-learn',
        'ordered-enum',
        'mat73',
        'dacite',
        'gdown',
        'timm',
        'transformers<4.50',  # Flash Attn compatibility
        'peft',
        'packaging',  # Flash Attn https://github.com/Dao-AILab/flash-attention
        'ninja',
        'rotary-embedding-torch',  # https://github.com/lucidrains/rotary-embedding-torch - compatibility fix in components.py
        'sentencepiece',  # Flash Attn
        'edit-distance',
        'falcon-challenge',
        'ruamel.yaml',
        'tensordict>=0.3.0',
        # 'flash-attn', # install following build instructions on https://github.com/Dao-AILab/flash-attention
        # pip install flash-attn --no-build-isolation
    ],
)