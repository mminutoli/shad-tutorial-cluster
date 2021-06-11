**************************************
A Docker cluster for tutorials on SHAD
**************************************

.. code-block:: shell

   $ docker compose build
   $ docker compose up -d --scale node=4
   $ bash ./gen_machines_list.sh
   $ ssh -p 2022 -i ssh/id_rsa.mpi tutorial@localhost

The container prompt should appear:

.. code-block:: shell

   $ mpiexec -n 4 --hostfile machines echo "Hello World"
   $ mpiexec -n 4 --hostfile machines ./SHAD-build/examples/pi/pi --gmt_num_workers 4
