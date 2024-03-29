# Introduction and initiation to Singularity / Apptainer  
Olivier Kirsh :  
<olivier.kirsh@u-paris.fr>  

This page summarize some usefull infomations to get started with Singularity/Apptainer containers.  

## Install Apptainer/Singularity  

This [tuto](https://github.com/apptainer/apptainer/blob/main/INSTALL.md) also works on win10 thanx to WSL. I haven't done any test on macOS.  

- Get WSL (Windows Subsystem for Linux) from the microsoft store if you aren't on a linux distribution.  

- Follow instructions from [Apptainer](https://apptainer.org/docs/user/main/quick_start.html)
The lines bellow works for my pc. Please read the doc, and adapt it to your setup.    

    - Install dependencies (kind of balck magics)  
    
    ```bash
    # Ensure repositories are up-to-date
    sudo apt-get update
    # Install debian packages for dependencies
    sudo apt-get install -y \
                build-essential \
                libseccomp-dev \
                pkg-config \
                squashfs-tools \
                cryptsetup \
                curl wget git
    ```
    
    - remove any previous GO installations (Disclaimer: if you really want to)    
    
    `sudo rm -rf /usr/local/go* && sudo rm -rf /usr/local/go`  
    
    - Install last GO version (check updates and personal setup)  
    
    ```bash
    VERSION=1.18  
    OS=linux   
    ARCH=amd64   
    cd $HOME  
    wget https://storage.googleapis.com/golang/go$VERSION.$OS-$ARCH.tar.gz  
    tar -xvf go$VERSION.$OS-$ARCH.tar.gz  
    mv go go-$VERSION  
    sudo mv go-$VERSION /usr/local  
    ```
    
    - Update your *.bashrc*  
    
    ```bash
    export GOROOT=/usr/local/go-1.18   
    export GOPATH=$HOME/projects/go   
    export GOBIN=$GOPATH/bin   
    export PATH=$PATH:$GOROOT/bin   
    export PATH=$PATH:$HOME/projects/go/bin  
    ```

    - Install last Singularity/Apptainer version
    
    ```bash
    # get singularity/Apptainer
    export VERSION=1.0.0 && # adjust this as necessary \
    wget https://github.com/apptainer/apptainer/releases/download/v${VERSION}/apptainer-${VERSION}.tar.gz && \
    tar -xzf apptainer-${VERSION}.tar.gz && \
    cd apptainer-${VERSION}
    
     # compile singularity
    ./mconfig && \
    make -C builddir && \
    sudo make -C builddir install
    ```
    


# Singularity Usefull links
Here are usefull links to get familiar with Singularity  

- [Singularity at IFB](https://ifb-elixirfr.gitlab.io/cluster/doc/software/singularity/), tuto and how to.  

<!-- old link http://taskforce-nncr.gitlab.cluster.france-bioinformatique.fr/doc/singularity/ -->


- [Nebraska HCC](https://hcc.unl.edu/docs/applications/user_software/using_singularity/) ressources.

<!-- old link https://hcc.unl.edu/docs/guides/running_applications/using_singularity/ -->


- [Version Control with Git](https://swcarpentry.github.io/git-novice/) SWC courses. Needed for many actions.  

- [(re)découvrez Git](https://fr.atlassian.com/git/tutorials/learn-git-with-bitbucket-cloud) en français.  

- [Utilisation basique de Singularity](https://indico.in2p3.fr/event/17206/contributions/64126/attachments/50157/63972/Singularity_01.pdf) (pdf).

- Singularity Hub, now nammed [datalad](http://datasets.datalad.org/?dir=/shub).


- [Singularity Hub - GitHub](https://github.com/singularityhub).


- [Singularity Hub, Deploy basic commands](https://github.com/singularityhub/singularityhub.github.io/wiki/Deploy#order-of-operations).

- [Singularity - old site](https://singularityware.github.io/index.html), the new doc is at this url https://apptainer.org/docs.  

- [Singularity Container Services, Sylabs documentation](https://sylabs.io/docs/) Docs (Sylabs).

- [Singularity Container Services, Sylabs user guide](https://sylabs.io/guides/3.2/user-guide/) User guide (Sylabs).

- [Formation bash git singularity](https://gitlab.mbb.univ-montp2.fr/docs/doc_user/formations/_book/form_singu/index.html), lien vers TP (en français).
- [Créer un conteneur avec Singularity](https://mbb.univ-montp2.fr/ust4hpc/tpSingu.html), TP Rémy Dernat.

- [How to build a Singularity container](https://souchal.pages.in2p3.fr/hugo-perso/2018/09/18/tp-how-to-build-a-singularity-container/) hands-on Martin Souchal.

- [Slides Tuto Singularity & Docker](https://souchal.pages.in2p3.fr/hugo-perso/2019/09/20/tutorial-singularity-and-docker/) Martin Souchal, 2019...

- [Slides intro Singularity](https://groupes.renater.fr/wiki/include-besancon/_media/rencontres/clerget_pres_singularity_cclerget.pdf) Cédric Clerget, 2016...


# Singularity / Apptainer versions on our clusters   

On 2022-09-05 the lastest Apptainer stable version is 1.1.0-rc.2.  

The installed version on our clusters are :

## iPOP-UP (-p ipop-up ).   

```
[kirsh@ipop-up ~]$ singularity --version                                                                                singularity version 3.8.5-2.el7 
```
For more infos about the cluster, read the [documentation](https://reyjul.gitlab.io/documentation-ipop-up/)    


## IFB Core (-p fast).  

```
[okirsh@core-login1 ~]$ singularity --version                                                                           singularity version 3.5.3 
```
For more infos about the cluster, read the [documentation](https://ifb-elixirfr.gitlab.io/cluster/doc/ )     

## Old UMR7216 (-p epignetique) cluster (disconnected)      

```
[kirsh@goliath ~]$ singularity --version
2.6.1-dist
```



# How to create a Singularity image

[RTFM](https://apptainer.org/docs/user/main/build_a_container.html ) for more details

<!-- old link https://sylabs.io/guides/3.2/user-guide/build_a_container.html -->

You must be **sudo** !! 

## From an existing Singularity image/Container

- from Sylab container library

```
sudo singularity build lolcow.simg library://sylabs-jms/testing/lolcow
```

- from shub (Singularity Hub archive)

```
sudo singularity build ngs2.simg shub://kirsho/ngs2
```
Note that shub is now read only. Alternative solutions are described [here](https://singularityhub.github.io/singularityhub-docs/2021/going-read-only/) to share and distribute your Singularity image.  



## From an existing docker image

Actually there is large interoperability between Docker and Singularity. It's really easy to start from a Docker image to create a Singularity image.  Details  [here](https://docs.sylabs.io/guides/2.6/user-guide/singularity_and_docker.html).  

- from docker Hub

```
sudo singularity build ngs2.sif docker://genomicpariscentre/bowtie2
```



## From a definition file (this is really cool)

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

Again read the manual to understand file contents.
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

### Last uptodate version of my definition files

This github repository hosts my last version of my Singularity file.  
This Singularity file as been used to test interoperability of conda envs between my local machine, ifb-nncr and RPBS cluster.  

[rst36-env](https://github.com/kirsho/rst36-env) github repository hosts :
- Singularity definition file for conda or yml environment creation
- an example of a yml file
You can clone it to build and use this this env.  

You can also see examples of definition files I use [here](https://github.com/kirsho/Singularity/tree/master/def]


# How to share and deploy your Singularity image

## By mail
Just send the `.def` file. Any user with Singularity installed in his machine can re-build the image.  

## With a hard drive, through scp, etc... 
Share the image. Quite stupid, could weight 1 Go at least.  Share the `def file` instead. But can be easier if your collaborators do not handle Singularity 

## on line With hubs
### Sylabs Hub
with `singularity push`.  
Requires version > 3.0.1.

### Singularity hub 
** this section must be updated since shub is now datalad.**  

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

use `git pull origin master --allow-unrelated-histories` if you already have files in your remote repository.  


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
conda env export --no-build -n bowtie2-2.3.4.3  -f ~/whereyouwant/bw223.yml
```

- Bring it back to HOME

```
scp ....
```
- Use this `.yml` in your `def file` to build your image




# Run / execute a Singularity image

shell, run & execute are the three main singularity verbs

- Use `singularity shell xxx.simg` to get a shell in your image.

- Use `singularity run xxx.simg xxxx.sh` to run a script in your image.  

- Use `singularity exec -B $PWD:/data shub://kirsho/bw223 bowtie2 --threads $SLURM_CPUS_PER_TASK -x mm10/mm10 $fq > ${fq/.fastq.gz/.sam}` to run a program in your image on a cluster. This command is excuted from an sbatch file. 

```
#!/bin/bash
#SBATCH --output=testbw223ifb-%j.out
#SBATCH --array=1-2
#SBATCH -p fast
#SBATCH --job-name=singbw2ifb
#SBATCH --cpus-per-task=12
#SBATCH --mail-user=olivier.kirsh@u-paris.fr
#SBATCH --mail-type=BEGIN
#SBATCH --mail-type=FAIL
#SBATCH --mail-type=END



case "$SLURM_ARRAY_TASK_ID" in

        1)      fq="ENCFF179JEC.fastq.gz"
                ;;

        2)      fq="ENCFF931IVO.fastq.gz"
        	;;

esac

singularity exec -B $PWD:/data shub://kirsho/bw223 bowtie2 --threads $SLURM_CPUS_PER_TASK -x mm10/mm10 $fq > ${fq/.fastq.gz/.sam}
```

Note that contrary to docker, Singularity image mount your current folder. You can change it name and path with `-B $PWD:/data `. In docker use `-v $PWD:/data `. this section deserve an update. Read [here](https://apptainer.org/docs/user/main/bind_paths_and_mounts.html?highlight=binding) for more details.  


# Updates
Since the first version of this page (2019-07-03), some changes have occured.  
Links and command have been updated on this page. Some broken url or depreciated commands may persist.   

## Singularity  
Singularity become [Apptainer](https://apptainer.org/) in may 2021.    
Singularity 3.6.8 -> apptainer-1.0.0  
New link to [documentation](https://apptainer.org/docs/user/main/quick_start.html) and to [Github](https://github.com/apptainer/singularity)  
The ```singularity xxxx``` commands still work with Apptainer.  

## Conda/Mamba  
Conda -> Mamba  
mamba added to conda locally and on my images via <https://anaconda.org/conda-forge/mamba>    
Mamba is faster in dependencies solving durring conda environment creation. For more information on mamba, read the [documentation](https://github.com/mamba-org/mamba) on github.  



 





