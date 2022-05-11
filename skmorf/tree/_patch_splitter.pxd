# distutils: language = c++

# Authors: Adam Li <adam2392@gmail.com>
#
# License: BSD 3 clause

# See _patch_splitter.pyx for details.

import numpy as np
cimport numpy as np

from sklearn.tree._criterion cimport Criterion

from sklearn.tree._tree cimport DTYPE_t          # Type of X
from sklearn.tree._tree cimport DOUBLE_t         # Type of y, sample_weight
from sklearn.tree._tree cimport SIZE_t           # Type for indices and counters
from sklearn.tree._tree cimport INT32_t          # Signed 32 bit integer
from sklearn.tree._tree cimport UINT32_t         # Unsigned 32 bit integer

from sklearn.tree._oblique_splitter cimport ObliqueSplitter
from sklearn.tree._oblique_splitter cimport ObliqueSplitRecord
from sklearn.utils._sorting cimport simultaneous_sort


from libcpp.vector cimport vector


cdef class ImagePatchSplitter(ObliqueSplitter):
    # sampling patch dimensions
    cdef public int min_patch_height
    cdef public int max_patch_height
    cdef public int min_patch_width
    cdef public int max_patch_width

    # the passed in 2D image dimensions
    cdef public int image_height
    cdef public int image_width

    # All oblique splitters (i.e. non-axis aligned splitters) require a
    # function to sample a projection matrix that is applied to the feature matrix
    # to quickly obtain the sampled projections for candidate splits.
    cdef void sample_proj_mat(self, 
                              vector[vector[DTYPE_t]]& proj_mat_weights,
                              vector[vector[SIZE_t]]& proj_mat_indices) nogil 


cdef class MtsPatchSplitter(ObliqueSplitter):
    # sampling patch dimensions over the 2D mts
    cdef public int min_patch_signals
    cdef public int max_patch_signals
    cdef public int min_patch_time
    cdef public int max_patch_time

    # the passed in 2D multivariate time-series dimensions
    cdef public int n_signals
    cdef public int n_time_points

    # All oblique splitters (i.e. non-axis aligned splitters) require a
    # function to sample a projection matrix that is applied to the feature matrix
    # to quickly obtain the sampled projections for candidate splits.
    cdef void sample_proj_mat(self, 
                              vector[vector[DTYPE_t]]& proj_mat_weights,
                              vector[vector[SIZE_t]]& proj_mat_indices) nogil 
