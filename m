Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from mga18.intel.com ([134.134.136.126]:40003 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726917AbeJPHz0 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 16 Oct 2018 03:55:26 -0400
From: Christopher Hall <christopher.s.hall@intel.com>
Subject: TSC to Mono-raw Drift
Date: Mon, 15 Oct 2018 12:09:45 -0400
Message-Id: <20181015160945.5993-1-christopher.s.hall@intel.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: tglx@linutronix.de, hpa@zytor.com, linux-rt-users@vger.kernel.org
Cc: jesus.sanchez-palencia@intel.com, gavin.hindman@intel.com, liam.r.girdwood@intel.com, peterz@infradead.org, Christopher Hall <christopher.s.hall@intel.com>

Problem Statement:

The TSC clocksource mult/shift values are derived from CPUID[15H], but the
monotonic raw clock value is not equal to TSC in nominal nanoseconds, i.e.
the timekeeping code is not accurately transforming TSC ticks to nominal
nanoseconds based on CPUID[15H}.

The included code calculates the drift between nominal TSC nanoseconds and
the monotonic raw clock.

Background:

Starting with 6th generation Intel CPUs, the TSC is "phase locked" to the
Always Running Timer (ART). The relation between TSC and ART is read from
CPUID[15H]. Details of the TSC-ART relation are in the "Invariant
Timekeeping" section of the SDM.

CPUID[15H].ECX returns the nominal frequency of ART (or crystal frequency).
CPU feature TSC_KNOWN_FREQ indicates that tsc_khz (tsc.c) is derived from
CPUID[15H]. The calculation is in tsc.c:native_calibrate_tsc().

When the TSC clocksource is selected, the timekeeping code uses mult/shift
values to transform TSC into nanoseconds. The mult/shift value is determined
using tsc_khz.

Example Output:

Running for 3 seconds trial 1
Scaled TSC delta: 3000328845
Monotonic raw delta: 3000329117
Ran for 3 seconds with 272 ns skew

Running for 3 seconds trial 2
Scaled TSC delta: 3000295209
Monotonic raw delta: 3000295482
Ran for 3 seconds with 273 ns skew

Running for 3 seconds trial 3
Scaled TSC delta: 3000262870
Monotonic raw delta: 3000263142
Ran for 3 seconds with 272 ns skew

Running for 300 seconds trial 4
Scaled TSC delta: 300000281725
Monotonic raw delta: 300000308905
Ran for 300 seconds with 27180 ns skew

The skew between tsc and monotonic raw is about 91 PPB. 

System Information:

CPU model string: Intel(R) Core(TM) i5-6600 CPU @ 3.30GHz
Kernel version tested: 4.14.71-rt44
	NOTE: The skew seems to be insensitive to kernel version after
		introduction of TSC_KNOWN_FREQ capability

>From CPUID[15H]:
	Time Stamp Counter/Core Crystal Clock Information (0x15):
		TSC/clock ratio = 276/2
		nominal core crystal clock = 24000000 Hz (table lookup)

TSC kHz used to calculate mult/shift value: 3312000



---
 time_drift/Makefile           |  16 ++++
 time_drift/test.sh            |  18 +++++
 time_drift/testtimedrift.c    |  90 ++++++++++++++++++++++
 time_drift/timedrift.c        | 140 ++++++++++++++++++++++++++++++++++
 time_drift/timedrift_common.h |   6 ++
 5 files changed, 270 insertions(+)
 create mode 100644 time_drift/Makefile
 create mode 100755 time_drift/test.sh
 create mode 100644 time_drift/testtimedrift.c
 create mode 100644 time_drift/timedrift.c
 create mode 100644 time_drift/timedrift_common.h

diff --git a/time_drift/Makefile b/time_drift/Makefile
new file mode 100644
index 000000000000..54baade15e2f
--- /dev/null
+++ b/time_drift/Makefile
@@ -0,0 +1,16 @@
+KERNEL_DIR=..
+
+obj-m+=timedrift.o
+
+all: build test
+
+build:
+	make -C $(KERNEL_DIR) M=$(PWD) modules
+	$(CC) testtimedrift.c -o test
+clean:
+	make -C $(KERNEL_DIR) M=$(PWD) clean
+	rm -f test
+
+.PHONY: test
+test:
+	sudo ./test.sh
diff --git a/time_drift/test.sh b/time_drift/test.sh
new file mode 100755
index 000000000000..c707ec22ebd2
--- /dev/null
+++ b/time_drift/test.sh
@@ -0,0 +1,18 @@
+#!/usr/bin/bash
+
+rmmod timedrift
+sleep 1
+insmod timedrift.ko
+sleep 1
+
+echo "Running for 3 seconds trial 1"
+./test 3
+echo
+echo "Running for 3 seconds trial 2"
+./test 3
+echo
+echo "Running for 3 seconds trial 3"
+./test 3
+echo
+echo "Running for 300 seconds trial 4"
+./test 300
diff --git a/time_drift/testtimedrift.c b/time_drift/testtimedrift.c
new file mode 100644
index 000000000000..fa2dff62b25f
--- /dev/null
+++ b/time_drift/testtimedrift.c
@@ -0,0 +1,90 @@
+#include <stdio.h>
+#include <stdlib.h>
+#include <stdint.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <string.h>
+#include <unistd.h>
+#include <sys/ioctl.h>
+#include <errno.h>
+#include <unistd.h>
+
+#include "timedrift_common.h"
+
+#define TSC_FREQ_CPUID 0x15
+#define DEFAULT_CRYSTAL_FREQ 24000000
+
+void read_cpuid( uint32_t *eax, uint32_t *ebx, uint32_t *ecx, uint32_t *edx )
+{
+        asm volatile
+                ("cpuid" :
+                 "=a" (*eax),
+                 "=b" (*ebx),
+                 "=c" (*ecx),
+                 "=d" (*edx)
+                 : "a" (*eax), "c" (0));
+}
+
+int main( int argc, char **argv )
+{
+   int ret, fd;
+   uint64_t start[2];
+   uint64_t end[2];
+   uint32_t reg[4];
+   uint64_t tsc_delta;
+   int duration;
+
+   if( argc < 2 )
+	   printf( "Require duration in seconds on command line" );
+
+   duration = atoi( argv[1] );
+
+   memset( &reg, 0, sizeof(reg));
+   reg[0] = TSC_FREQ_CPUID;
+   read_cpuid( reg, reg+1, reg+2, reg+3 );
+   if( reg[2] == 0 )
+	   reg[2] = 24000000;
+
+   fd = open( "/dev/timedrift0", O_RDWR );
+   if( fd < 0 )
+   {
+      perror("Failed to open the device...");
+      return errno;
+   }
+
+   while( 1 )
+   {
+	   if( ioctl( fd, TIMEDRIFT_IOCTL, &start ) != 0 )
+	   {
+		   if( errno == EAGAIN )
+			   continue;
+		   else
+			   break;
+	   }
+	   sleep(duration);
+	   if( ioctl( fd, TIMEDRIFT_IOCTL, &end ) != 0 )
+	   {
+		   if( errno == EAGAIN )
+			   continue;
+		   else
+			   break;
+	   }
+	   break;
+   }
+		   
+   tsc_delta = end[0] - start[0];
+   tsc_delta *= reg[0]*10000;
+   tsc_delta /= reg[1]*(reg[2]/100000);
+	   
+   if( errno != 0 )
+	   printf( "Fatal error occured retrieving timestamp: %s\n",
+		   strerror(errno));
+   printf( "Scaled TSC delta: %lu\n", tsc_delta );
+   printf( "Monotonic raw delta: %lu\n", end[1] - start[1] );
+   printf( "Ran for %d seconds with %lld ns skew\n", duration,
+	   llabs( tsc_delta - (end[1] - start[1])));
+
+   close( fd );
+
+   return 0;
+}
diff --git a/time_drift/timedrift.c b/time_drift/timedrift.c
new file mode 100644
index 000000000000..a63b5a9edaa7
--- /dev/null
+++ b/time_drift/timedrift.c
@@ -0,0 +1,140 @@
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/kernel.h>
+#include <linux/fs.h>    
+#include <linux/uaccess.h>
+#include <linux/ktime.h>
+
+#include "timedrift_common.h"
+
+#define DEVICE_NAME	"timedrift0"
+#define CLASS_NAME	"timedrift"
+
+MODULE_LICENSE("GPL");   
+MODULE_AUTHOR("Cristobal");
+MODULE_DESCRIPTION("Simple driver test Montonic Raw vs TSC drift");
+MODULE_VERSION("0.1");
+
+static bool _init = false;
+static u8 clocksource_sequence;
+static int    majorNumber;
+static struct class*  timedriftClass  = NULL;
+static struct device* timedriftDevice = NULL;
+
+// The prototype functions for the character driver -- must come before the struct definition
+static int	dev_open(struct inode *, struct file *);
+static int	dev_release(struct inode *, struct file *);
+static long	dev_ioctl( struct file *filp, unsigned int cmd,
+			   unsigned long arg );
+
+static struct file_operations fops =
+{
+   .open =		dev_open,
+   .release =		dev_release,
+   .unlocked_ioctl =	dev_ioctl,
+};
+
+static int __init timedrift_init(void){
+	majorNumber = register_chrdev(0, DEVICE_NAME, &fops);
+	if( majorNumber < 0 )
+	{
+		printk( KERN_ALERT
+			"Timedrift failed to register a major number\n" );
+		return majorNumber;
+	}
+
+   // Register the device class
+   timedriftClass = class_create(THIS_MODULE, CLASS_NAME);
+   if( IS_ERR( timedriftClass ))
+   {
+	   unregister_chrdev( majorNumber, DEVICE_NAME );
+	   printk( KERN_ALERT "Failed to register device class\n" );
+	   return PTR_ERR( timedriftClass );
+   }
+
+   // Register the device driver
+   timedriftDevice = device_create
+	   ( timedriftClass, NULL, MKDEV(majorNumber, 0), NULL, DEVICE_NAME );
+
+   if( IS_ERR( timedriftDevice ))
+   {
+	   class_destroy( timedriftClass );
+	   unregister_chrdev( majorNumber, DEVICE_NAME );
+	   printk( KERN_ALERT "Failed to create the device\n" );
+	   return PTR_ERR( timedriftDevice );
+   }
+
+   printk( KERN_INFO
+	   "Timedrift: loaded\n" );
+
+   return 0;
+}
+
+static void __exit timedrift_exit(void){
+	device_destroy( timedriftClass, MKDEV( majorNumber, 0 ));
+	class_unregister(timedriftClass);
+	class_destroy(timedriftClass);
+	unregister_chrdev(majorNumber, DEVICE_NAME);
+
+	printk( KERN_INFO "Timedrift: unloaded\n" );
+}
+
+static long dev_ioctl( struct file *filp, unsigned int cmd, unsigned long arg )
+{
+	int ret = 0;
+
+	switch( cmd )
+	{
+	default:
+		return -1;
+		
+	case TIMEDRIFT_IOCTL:
+	{
+		u64 clock[2];
+		struct system_time_snapshot snap;
+
+		ktime_get_snapshot( &snap );
+		
+		if( _init && clocksource_sequence != snap.cs_was_changed_seq )
+			ret = -EAGAIN;
+		else
+			_init = true;
+
+		clocksource_sequence = snap.cs_was_changed_seq;
+		if( ret != 0 )
+			goto done;
+
+		clock[0] = snap.cycles;
+		clock[1] = snap.raw;
+		if( copy_to_user( (void *)arg, clock, sizeof( clock ))
+		    != 0 )
+		{
+			printk( KERN_INFO "Copy to user failed\n" );
+			return -EINVAL;
+		}
+
+		break;
+	}
+	}
+
+	done:
+	return ret;
+}
+
+static int dev_open( struct inode *inodep, struct file *filep )
+{
+	printk( KERN_INFO "Timedrift: device has been opened\n" );
+
+	return 0;
+}
+
+static int dev_release( struct inode *inodep, struct file *filep )
+{
+	printk(KERN_INFO "Timedrift: device successfully closed\n");
+
+	return 0;
+}
+
+module_init(timedrift_init);
+module_exit(timedrift_exit);
diff --git a/time_drift/timedrift_common.h b/time_drift/timedrift_common.h
new file mode 100644
index 000000000000..90daa85a6597
--- /dev/null
+++ b/time_drift/timedrift_common.h
@@ -0,0 +1,6 @@
+#ifndef TD_COMMON_H
+#define TD_COMMON_H
+
+#define TIMEDRIFT_IOCTL 0xdeadb33f
+
+#endif/*TD_COMMON_H*/
-- 
2.17.2
