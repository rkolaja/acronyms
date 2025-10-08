# Basic Acronym Discovery

Take reports written in MS Word and find all the acronyms.

## Requirements

Perl and Carton must be installed on your host. If you're running on Linux, Perl
is probably already available. To install Carton system wide, run the following:

```sh
sudo cpanm -n Carton
```

Now that Carton is installed, the script's dependencies can be installed by
executing the following command from the directory containing `cpanfile`:

```sh
carton install
```

> [!TIP]
> **This project ships with a [devcontainer].** Use VS Code to open this
> repository inside a devcontainer and save yourself the hassle of installing
> dependencies. You'll need to ensure [Docker is installed][docker_install].

  [devcontainer]: https://containers.dev/
  [docker_install]: https://docs.docker.com/engine/install/

## Usage

To use this script, export your document as a plaintext file. Then run the
following:

```sh
acronyms.pl /path/to/plaintext/report.txt
```

> [!NOTE]
> If using the devcontainer, copy the text file to the same directory as
> `acronyms.pl`, else it won't be available in the container.

## Output

The discovered acronyms and number of occurrences will be printed to the
terminal in CSV format. To capture this in a file, use a redirect as follows:

```sh
acronyms.pl /path/to/plaintext/report.txt > acronyms.csv
```

Now, `acronyms.csv` can be opened in MS Excel or any other CSV viewer of your
choice.
