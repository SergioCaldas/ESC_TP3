/*
   inline int O_RDONLY = 0;
   inline int O_WRONLY = 1;
   inline int O_RDWR = 2;
   inline int O_APPEND = 8;
   inline int O_CREAT = 256;
 */

this string flag_string;

syscall::openat:entry
/(arg2 & O_CREAT)==O_CREAT/
{
	@create[execname,pid] = count();
}

syscall::openat*:entry
/(arg2 & O_CREAT) == 0/ {
	@open[execname, pid] = count();
}

syscall::openat*:return
/ arg1 > 0 / {
	@success[execname, pid] = count();
}

tick-$1s
{
	printf("%12s %6s %6s %6s %s\n","EXECNAME", "PID", "CREATE", "OPEN", "SUCCESS");
	printf ("%Y\n",walltimestamp);
	printa ("%12s %6d %@6d %@6d %@d\n", @create, @open, @success);
	trunc(@create); 
	trunc(@open); 
	trunc(@success);
}

