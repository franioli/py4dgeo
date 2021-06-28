FROM jupyter/base-notebook:584f43f06586

# Install dependencies from Conda
RUN conda install -c conda-forge \
      cmake \
      eigen \
      gxx_linux-64 \
      make \
      pcl && \
    conda clean -a -q -y

# Copy the repository into the container
COPY --chown=${NB_UID} . /opt/py4dgeo

# Build and install the project
RUN conda run -n base python -m pip install /opt/py4dgeo

# Temporarily install the dev requirements
RUN conda run -n base python -m pip install -r /opt/py4dgeo/requirements-dev.txt

# Copy all the notebook files into the home directory
RUN rm -rf ${HOME}/work && \
    cp /opt/py4dgeo/jupyter/* ${HOME}

# Make JupyterLab the default for this application
ENV JUPYTER_ENABLE_LAB=yes
