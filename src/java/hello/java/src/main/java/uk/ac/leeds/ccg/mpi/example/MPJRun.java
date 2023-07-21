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

import java.io.BufferedWriter;
import java.io.IOException;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.logging.Level;
import java.util.logging.Logger;
import mpi.MPI;
import mpi.MPIException;
import uk.ac.leeds.ccg.io.IO_Utilities;
//import mpi.Request;
//import mpi.Status;

/**
 * A class to extend for using MPJ Express.
 *
 * @author Andy Turner
 */
public abstract class MPJRun {

    BufferedWriter log = null;

    /**
     * For storing the number of processes
     */
    protected int size;

    /**
     * For storing the rank of process
     */
    protected int rank;

    /**
     * The name of the node/processor on which the rank is running.
     */
    protected String name;

    /**
     * Create a new instance.
     */
    public MPJRun() {
    }

    /**
     * Create a new instance.
     *
     * @param args The command line arguments.
     */
    public MPJRun(String[] args) {
        try {
            MPI.Init(args);
            size = MPI.COMM_WORLD.Size();
            rank = MPI.COMM_WORLD.Rank();
            name = MPI.Get_processor_name();
        } catch (MPIException ex) {
            Logger.getLogger(MPJRun.class.getName()).log(Level.SEVERE, null, ex);
        }
        // Initialise log
        try {
            Path dir = Paths.get(System.getProperty("user.dir"));
            Path f = IO_Utilities.createNewFile(dir, "java" + "rank", "out");
            log = IO_Utilities.getBufferedWriter(f, false);
            String s;
            if (rank == 0) {
                s = "Major " + name + ", rank " + rank + ", size " + size + ".";
            } else {
                s = "Minor " + name + ", rank " + rank + ".";
            }
            System.out.println(s);
            log.write(s);
        } catch (IOException ex) {
            Logger.getLogger(Run1.class.getName()).log(Level.SEVERE, null, ex);
        }
        /*
            Map<String, String> map = System.getenv();
            String mpjHomeDir = map.get("MPJ_HOME");
            System.out.println(mpjHomeDir);
            for (String key : map.keySet()) {
                System.out.println(key + ", " + map.get(key));
            }
         */
    }

    /**
     * Finalize MPI Environment.
     */
    public void finalizeMPI() {
        try {
            MPI.Finalize();
        } catch (MPIException ex) {
            Logger.getLogger(MPJRun.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
