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

import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;
import mpi.MPI;

/**
 * Example executable class where each minor rank sends their processor name to
 * the major rank to print out.
 *
 * @author Andy Turner
 */
public class Run1 extends MPJRun {

    int tag;

    /**
     * Create a new instance
     */
    public Run1() {
    }

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        new Run1().run(args);
    }

    public void run(String[] args) {
        tag = 50;
        String namer = "";
        int nameLength = 0;
        if (rank == 0) {
            System.out.println("Major " + name + ", rank " + rank + ".");
/*          for (int source = 1; source < size; source++) {
                MPI.COMM_WORLD.Recv(nameLength, 0, 1, MPI.INT, source, tag);
                MPI.COMM_WORLD.Recv(
                        namer, 0, nameLength, MPI.CHAR, source, tag);
                try {
                    String s = "Minor " + namer + ", rank " + source + ".";
                    System.out.println(s);
                    log.write(s);
                } catch (IOException ex) {
                    Logger.getLogger(Run1.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
*/
        } else {
            System.out.println("Minor " + name + ", rank " + rank + ".");
/*          for (int source = 1; source < size; source++) {
                MPI.COMM_WORLD.Isend(name.length(), 0, 1, MPI.INT, 0, tag);
                MPI.COMM_WORLD.Isend(name, 0, name.length(), MPI.CHAR, 0, tag);
            }
/*
        }
//        MPI.COMM_WORLD.Barrier();
        finalizeMPI();
    }
}
