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
        char[] test = null;
        String name = MPI.Get_processor_name();
        char[] chars = name.toCharArray();
        int count[] = new int[1];
        if (rank == 0) {
            System.out.println("Major " + name + ", rank " + rank + ", size " + size + ".");
            for (int source = 1; source < size; source++) {
                MPI.COMM_WORLD.Recv(count, 0, 1, MPI.INT, source, source);
                MPI.COMM_WORLD.Recv(chars, 0, count[0], MPI.CHAR, source, source + size);
                String s = "Minor " + String.valueOf(chars) + ", rank " + source + ".";
                System.out.println(s);
            }
        } else {
            //System.out.println("Minor " + name + ", rank " + rank + ".");
            count[0] = chars.length;
            MPI.COMM_WORLD.Send(count, 0, 1, MPI.INT, 0, rank);
            MPI.COMM_WORLD.Send(chars, 0, count[0], MPI.CHAR, 0, rank + size);
        }
//        MPI.COMM_WORLD.Barrier();
        //finalizeMPI();
        MPI.Finalize();
    }
}
