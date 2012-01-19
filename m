From: Forconi <forconi@wavecomm.it>
Subject: RT_PREEMPT with RS232 and USB-RS232 adapter
Date: Thu, 19 Jan 2012 10:34:05 -0000 (UTC)
Message-ID: <38e80508-f150-4e9a-b0d4-303a391e8007@zmail.sgconsulting.it>
References: <f599ebee-26a6-4db9-a47a-58524ee29b99@zmail.sgconsulting.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from zmail.sgconsulting.it ([174.143.207.116]:33911 "EHLO
	zmail.sgconsulting.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750978Ab2ASKlM (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 19 Jan 2012 05:41:12 -0500
Received: from localhost (localhost [127.0.0.1])
	by zmail.sgconsulting.it (Postfix) with ESMTP id 62C66584054
	for <linux-rt-users@vger.kernel.org>; Thu, 19 Jan 2012 10:34:06 +0000 (UTC)
Received: from zmail.sgconsulting.it ([127.0.0.1])
	by localhost (zmail.sgconsulting.it [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UmC1wZSUtKcL for <linux-rt-users@vger.kernel.org>;
	Thu, 19 Jan 2012 10:34:05 +0000 (UTC)
Received: from zmail.sgconsulting.it (zmail.sgconsulting.it [174.143.207.116])
	by zmail.sgconsulting.it (Postfix) with ESMTP id 8ACD7584095
	for <linux-rt-users@vger.kernel.org>; Thu, 19 Jan 2012 10:34:05 +0000 (UTC)
In-Reply-To: <f599ebee-26a6-4db9-a47a-58524ee29b99@zmail.sgconsulting.it>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,
I'm working on an RT_PREEMPT patched kernel to test a small C program that sends 39B of data on the serial line every 50ms.
I'm testing the timing accuracy using a scope on the TX pin of the serial cable.
When I run the application using /dev/ttyS0 as serial port I see data starting every 50ms, but when I run the application using a Prolific PL2303 USB-RS232 adapter on /dev/ttyUSB0 I see data out every 250ms.
Is this possible or I'm doing something wrong?

This is the source file of the program I'm using for my test (I modified the "Hello World" example on RT PREEMPT HOWTO page):

#include <stdlib.h>
#include <stdio.h>
#include <time.h>
#include <sched.h>
#include <sys/mman.h>
#include <string.h>

#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <termios.h>


#define MY_PRIORITY (79) 

#define MAX_SAFE_STACK (8*1024) /* The maximum stack size which is
                                   guranteed safe to access without
                                   faulting */

#define NSEC_PER_SEC    (1000000000) /* The number of nsecs per sec. */

#define BAUDRATE B9600
#define _POSIX_SOURCE 1 /* POSIX compliant source */


void stack_prefault(void) {

        unsigned char dummy[MAX_SAFE_STACK];

        memset(dummy, 0, MAX_SAFE_STACK);
        return;
}

int main(int argc, char* argv[])
{
        struct timespec t;
        struct sched_param param;
        int interval = 50000000; /* 50ms*/
        int fd, c;
        struct termios oldtio, newtio;
        char buf[39];

        /* Declare ourself as a real time task */
	printf("[1]\n");

        param.sched_priority = MY_PRIORITY;
        if(sched_setscheduler(0, SCHED_FIFO, &param) == -1) {
                perror("sched_setscheduler failed");
                exit(-1);
        }

        /* Lock memory */

        if(mlockall(MCL_CURRENT|MCL_FUTURE) == -1) {
                perror("mlockall failed");
                exit(-2);
        }

        /* Pre-fault our stack */
	printf("[2]\n");

        stack_prefault();

        clock_gettime(CLOCK_MONOTONIC ,&t);
        
        /* start after one second */
        t.tv_sec++;
        
        /* open serial port */
        fd = open(argv[1], O_WRONLY | O_NOCTTY); 
        if (fd <0) { 
        	perror(argv[1]); 
        	exit(-1); 
        }
        
        tcgetattr(fd, &oldtio); /* save current port settings */
        
        bzero(&newtio, sizeof(newtio));
        newtio.c_cflag = BAUDRATE | CS8 | CLOCAL | CREAD;
        newtio.c_iflag = IGNPAR;
        newtio.c_oflag = 0;
        newtio.c_lflag = 0;
        
        /* set input mode (non-canonical, no echo,...) */
        newtio.c_lflag = 0;
         
        newtio.c_cc[VTIME]    = 0;   /* inter-character timer unused */
        newtio.c_cc[VMIN]     = 1;   /* blocking read until 1 chars received */
        
	printf("[3]\n");

        tcflush(fd, TCIFLUSH);
        tcsetattr(fd, TCSANOW, &newtio);

	printf("[4]\n");        

        for(c = 0; c < 39; c++)
        	buf[c] = 0xFF;

	printf("writing 39B to serial port %s\n",argv[1]);
        while(1) {
                /* wait until next shot */
                clock_nanosleep(CLOCK_MONOTONIC, TIMER_ABSTIME, &t, NULL);

                /* do the stuff */                
                write(fd, buf, 39);
                
                /* calculate next shot */
                t.tv_nsec += interval;

                while (t.tv_nsec >= NSEC_PER_SEC) {
                       t.tv_nsec -= NSEC_PER_SEC;
                        t.tv_sec++;
                }
   }
}
