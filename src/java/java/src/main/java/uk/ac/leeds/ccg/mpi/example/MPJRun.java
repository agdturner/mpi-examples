/*
 * Copyright 2023 CCG, University of Leeds.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package uk.ac.leeds.ccg.mpi.example;

import mpi.MPIException;
import mpi.MPI;
//import mpi.Request;
//import mpi.Status;

/**
 * A class to extend for using MPJ Express.
 * 
 * @author Andy Turner
 */
public abstract class MPJRun {

    /**
     * For storing the number of processes
     */
    protected int size;
	
    /**
     * For storing the rank of process
     */
    protected int rank;

    /**
     * Default Constructor
     */
    public MPJRun() {
    }

    /**
     * Initialize MPI Environment.
     * @param args
     */
    public void initMPI(String[] args) {
        try {
            MPI.Init(args);
        } catch (MPIException ex) {
            System.err.println(ex.getLocalizedMessage());
        }
        try {
            size = MPI.COMM_WORLD.Size();
            rank = MPI.COMM_WORLD.Rank();
        } catch (MPIException ex) {
            System.err.println(ex.getLocalizedMessage());
        }
    }

    /**
     * Finalize MPI Environment.
     */
    public void finalizeMPI() {
        try {
            MPI.Finalize();
        } catch (MPIException ex) {
            System.err.println(ex.getLocalizedMessage());
        }
    }
}