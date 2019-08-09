# Introduction and initiation to singularity
- links
- tutorials
- tests

olivier kirsh <olivier.kirsh@u-paris.fr>
20190703

# Purpose
Benchmark/test of interoperability between RPBS, IFB cluster architectures

# Singularity Usefull links
no specific order.

- [Singularity at IFB](http://taskforce-nncr.gitlab.cluster.france-bioinformatique.fr/doc/singularity/), tuto and how to.

- [Nebraska HCC](https://hcc.unl.edu/docs/guides/running_applications/using_singularity/) ressources.

- [Version Control with Git](https://swcarpentry.github.io/git-novice/) SWC courses. Needed for many actions.  

- [(re)découvrez Git](https://fr.atlassian.com/git/tutorials/learn-git-with-bitbucket-cloud) en français.  

- [Utilisation basique de Singularity](https://indico.in2p3.fr/event/17206/contributions/64126/attachments/50157/63972/Singularity_01.pdf) (pdf).

- [Singularity Hub](https://www.singularity-hub.org/).

- [Singularity Hub - GitHub](https://github.com/singularityhub).

- [Singularity Hub, Deploy basic commands](https://github.com/singularityhub/singularityhub.github.io/wiki/Deploy#order-of-operations).

- [Singularity - old site](https://singularity.lbl.gov/).

- [Singularity Container Services - new site](https://cloud.sylabs.io/home) (Sylabs).

- [Singularity Container Services - new site](https://sylabs.io/docs/) Docs (Sylabs).

- [Singularity Container Services - new site](https://sylabs.io/guides/3.2/user-guide/) User guide (Sylabs).

- [Formation bash git singularity](https://gitlab.mbb.univ-montp2.fr/docs/doc_user/formations/_book/form_singu/index.html), lien vers TP (en français).
- [Créer un conteneur avec Singularity](https://mbb.univ-montp2.fr/ust4hpc/tpSingu.html), TP Rémy Dernat.

- [Créer un conteneur avec Singularity](http://www.apc.univ-paris7.fr/~souchal/2018/03/06/tp--cr%C3%A9er-un-conteneur-avec-singularity/) TP Martin Souchal.

- [Slides intro Singularity](http://www.apc.univ-paris7.fr/~souchal/presentations/Singularity/prez.html#1) Martin Souchal, 2017...

- [Slides intro Singularity](https://groupes.renater.fr/wiki/include-besancon/_media/rencontres/clerget_pres_singularity_cclerget.pdf) Cédric Clerget, 2016...


# Singularity versions used at my working places

On 20190704 the lastest stable version is 3.2.  
it includes `push` to share images at [Sylabs Cloud hub](https://cloud.sylabs.io/home).  


## ifbcore (nncr)

```
(base) [okirsh@clust-slurm-client ~]$ singularity --version
singularity version 3.0.3
```

## RBPS (-p epignetique cluster)

```
[kirsh@goliath ~]$ singularity --version
2.6.1-dist
```

## On my machine
I choose to install the same version as goliath

### installation

Many ways to get **Singularity** installed on linux systems  
You can follow [this](https://singularity.lbl.gov/install-linux)

#### APT   

Try on your machine or on a **docker** container.   

```
sudo apt-get install -y singularity-container
root@ffba97fc507f:/# singularity --version
2.6.1-dist

```
works fine.  

#### Compile from source  

Sylabs [site](https://sylabs.io/guides/3.2/user-guide/quick_start.html#quick-installation-steps) provides instructions

- Check dependencies
- Install **Go** and update `.bashrc`.  
- Get the desired [version](https://github.com/singularityware/singularity/releases)

```
VERSION=2.5.2
wget https://github.com/singularityware/singularity/releases/download/$VERSION/singularity-$VERSION.tar.gz
tar xvf singularity-$VERSION.tar.gz
cd singularity-$VERSION
./configure --prefix=/usr/local
make
sudo make install
```

Installation by compiling the code did not work perfectly.  
Too many messages telling something goes wrong.  
`make` (etc...) is like voodoo. Requires some sacrifices and magics to make it works!

#### Conda

Explore file section to find your version  
Or install the lastest (linux-64/singularity-3.0.1-h47021f1_1000.tar.bz2) with :

```
conda install -c conda-forge singularity
```
Works fine too, ok to explore the help... But stupid to isolate **singularity** in a **conda** env. You also can't build images locally because of `sudo` requirement.  


#### Git repository

With `git clone`.  
Choose version with [checkout](https://fr.atlassian.com/git/tutorials/using-branches/git-checkout) argument.  

```
git clone https://github.com/singularityware/singularity.git
cd singularity
git fetch --all
git checkout 2.6.1
./autogen.sh
./configure --prefix=/usr/local
make
sudo make install
```

It requires that I install 'libarchive-dev' package  

```
sudo apt-get install libarchive-dev
```

Works fine.  


# How to create a Singularity image

[RTFM](https://sylabs.io/guides/3.2/user-guide/build_a_container.html) for more details

## From an existing Singularity image/Container

- from Sylab container library

```
sudo singularity build lolcow.simg library://sylabs-jms/testing/lolcow
```

- from shub

```
sudo singularity build ngs2.simg shub://kirsho/ngs2
```


## From an existing docker image

- from docker Hub

```
sudo singularity build ngs2.sif docker://genomicpariscentre/bowtie2
```



## From a definition file

Like Docker with a docker file, you can build a Singularity image with a recipe (a definition file).
Note that you can run /  execute a Singularity image without  "creating" it before. the `singularity exec` (or `pull` or `shell`) will do it for you if you provide the right link to the repository.

But if you want to do it, the command is as simple as:

```
sudo singularity build myimage.simg myimage.def
```

Note that you can name your image as .simg or `.sif`
Note that you can name your definition file as `.def` or `Singularity` (needed when you want to deploy through shub, see further sections)

[RTFM](https://singularity.lbl.gov/docs-build-container) old docs
[RTFM](https://sylabs.io/guides/3.2/user-guide/build_a_container.html) new docs


### What is a definition file

Again read the manual to understand file content.
Basically what it does is :
- calling a docker image with a linux/debian and miniconda already installed. More details here [continuumio/miniconda3](https://hub.docker.com/r/continuumio/miniconda3)
- Set and add conda inthe PATH
- Create a conda env with my ngs tools env "ngs3"

```
Bootstrap: docker

From: continuumio/miniconda3

%files
    ngs3.yml

%environment
    PATH=/opt/conda/envs/$(head -1  ngs3.yml | cut -d' ' -f2)/bin:$PATH         # Change $PATH

%post
    echo "Creating a Singularity Container of my ngs3 Conda Env"                # What I'm doing
    echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc                     # enable conda for the current
    echo "conda activate $(head -1  ngs3.yml | cut -d' ' -f2)" >> ~/.bashrc     # will start "ngs3" conda env
    apt-get update && apt-get -y install nano tree htop wget build-essential    # Install some extras
    /opt/conda/bin/conda update -n base -c defaults conda                       # Update Conda
    /opt/conda/bin/conda env create -f ngs3.yml                                 # Conda create my env

%runscript
    exec "$@"

%labels
    Maintainer olivier.kirsh@u-paris.fr
    Version v1.0 20190701
```


- Create the Singularity image with :

```
sudo singularity build ngs3.simg ngs3.def
```


# How to share and deploy your Singularity image

## By mail
Just send the `.def` file. Any user with Singularity installed in his machine can re-build the image

## With a hard drive, through scp
Share the image. quite stupid, could weight 1 Go at least.  Share the `def file`

## With hubs
### Sylabs Hub
with `singularity push`.  
Requires version > 3.0.1

### Singularity hub
[shub](https://www.singularity-hub.org/) container registry
It works with your github account

- login to github
- Create a new repository
- open a terminal and to your working folder containing the `def file` nammed `Singularity` and type:

```
git init

git add Singularity

git commit -m "first commit"

git remote add origin https://github.com/kirsho/ngs2.git

git remote -v

git push origin master

```
shub will create the [image](https://www.singularity-hub.org/collections/3244). it can take few minutes.

How to use them is explained [here](https://www.singularity-hub.org/collections/3244/usage)



## Create a Singularity image from a conda env

The above image example include ngs tools 'insulated' in a conda environment.
Conda is wonderfull since it allows the creation of separated envs where different versions of a software or incompatible application can coexist on a unique machine.
Conda is also wonderfull because it allows easy installation of an application with all its dependencies, whatever your machine is.

This recipe works whatever the conda env is local or at IFB

### From my conda env nammed ngs3 on my machine

- Open a terminal and load conda (via an alias in my bashrc, it's the way I configure it)

```
condainit
```
- Export conda env recipe in a yml file

```
conda env export --no-build -n ngs3 -f ~/whereyouwant/ngs3.yml
```
- Use this `.yml` in your `def file` to build your image


### From a conda env at ifb

- Login to ifbcore via ssh

```
ssh .....
```

- Explore available conda envs

```
conda env list
```

```
Last login: Wed Jul  3 10:28:18 2019 from edc95.sdv.univ-paris-diderot.fr
(base) [okirsh@clust-slurm-client ~]$ conda env list
# conda environments:
#
base                  *  /shared/mfs/data/software/miniconda
bcftools-1.9             /shared/mfs/data/software/miniconda/envs/bcftools-1.9
bedtools-2.26.0          /shared/mfs/data/software/miniconda/envs/bedtools-2.26.0
bedtools-2.27.1          /shared/mfs/data/software/miniconda/envs/bedtools-2.27.1
biokevlar-0.6.1          /shared/mfs/data/software/miniconda/envs/biokevlar-0.6.1
blast-2.7.1              /shared/mfs/data/software/miniconda/envs/blast-2.7.1
bowtie-1.2.2             /shared/mfs/data/software/miniconda/envs/bowtie-1.2.2
...
...

```

- Export recipe of the env you want to "clone".
```
conda env export -n bowtie2-2.3.4.3  -f ~/whereyouwant/bw223.yml
```

- Bring it back to HOME

```
scp ....
```
- Use this `.yml` in your `def file` to build your image



# Run / execute a Singularity image
