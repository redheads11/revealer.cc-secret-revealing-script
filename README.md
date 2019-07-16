# Script for revealing secret combining two Revealer.cc pdfs

## Revealer.cc

Revealer.cc is a method of encrypting a secret optically. More details [on their website](https://revealer.cc/).

## This script

Script requires two PDF as input. One is the revealer and the other is the secret. The script combines them into a single PNG image that reveals the secret.

The two input PDF files are generated by an Electrum wallet using the revealer.cc plugin ('Revealer Backup Utility'). You can read here [how to use with Electrum](https://revealer.cc/how-to-use/)).

## Use case

Can be used to split into two parts a secret. The parts by themselves cannot reveal the secret. They need to be combined to be of use.

Most commonly used for a wallet's seed phrase (BIP39). But can be used through Electrum for any custom text (up to 189 chars long).

## Requirement

To install required packages on Ubuntu:

```bash
$ sudo apt-get install poppler-utils imagemagick-6.q16
```

We are using:
	* `pdftoppm` from package `poppler-utils`
	* `convert` from package `imagemagick-6.q16`

## Syntax

```bash
$ ./script <revealer.pdf> <secret.pdf>
```

Given the nature of the combining operation (XOR), the order of the files does not matter (though this will affect the name of the resulting PNG file).

## Example execution

```bash
$ ./script.sh ./revealer_1_589.pdf ./custom_secret_1_589.pdf
* Revealer: 'revealer_1_589' / Secret: 'custom_secret_1_589'
* Converting PDFs to PNGs
* Converting revealer image to transparent
* Superimposing transparent revealer image on secret image for final result
* Done! Image with revealed secret: 'custom_secret_1_589_revealed_secret.png'
```

## Troubleshooting

If the text in the final image is not clearly visible, tweak the `-fuzz` % value in the script. Trials have shown that the default 30% gives reasonable results.
