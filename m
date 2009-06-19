From: GeunSik Lim <leemgs1@gmail.com>
Subject: Re: Test Scenario for Realtime latency benchmark in the worstcase
	environment.
Date: Fri, 19 Jun 2009 13:55:14 +0900
Message-ID: <49b7c2350906182155s1183ca18xb774ec4258fc8d84@mail.gmail.com>
References: <1245368556.2153.10.camel@centos51>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: tglx <tglx@linutronix.de>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-gx0-f214.google.com ([209.85.217.214]:63335 "EHLO
	mail-gx0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751017AbZFSEzN (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 19 Jun 2009 00:55:13 -0400
Received: by gxk10 with SMTP id 10so2518364gxk.13
        for <linux-rt-users@vger.kernel.org>; Thu, 18 Jun 2009 21:55:15 -0700 (PDT)
In-Reply-To: <1245368556.2153.10.camel@centos51>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, Jun 19, 2009 at 8:42 AM, GeunSik Lim<leemgs1@gmail.com> wrote:

> Prepare cyclictest(rt-tests), taskset, chrt, ltp-full-20090531.tar.gz ,
> hackbench , ping, dd, tar, netperf commands.

I uploaded graphical test  scenario map file to help understanding.
Now available from:
http://blogfiles13.naver.net/data44/2009/6/19/108/latency-worstcase-testscenario-invain.png

and, I summarized  commands that I used  to measure Realtime latency
with cyclictest.
Hope it helps.
If you have a some problems with this test secnario in the future. contact me.

Thks,

-----------------------------------------------------------------------------------------------------------------------------------------------------------------
package name	                       command	              web-address	

     license
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
util-linux-ng-2.13	                taskset	
ftp://ftp.kernel.org/pub/linux/utils/util-linux-ng	
                 GPL2 + BSD
	                                        chrt		
	                                        nice
                                                renice		
coreutils-6.10-33	                dd	
http://www.gnu.org/software/coreutils/	
             GPLV3
RT-Tests	                                cyclictest	
http://www.kernel.org/pub/linux//kernel/people/clrkwllms/rt-tests/	
 GPLV2
	                                        pi_tests		

                  GPLV2
	                                        signaltest		

                    GPLV2
LTP	                                        ltp	
http://ltp.sourceforge.net (formerly IBM Test Cases)	
           GPLV2
hackbench(Process,Thread)	hackbench	
http://people.redhat.com/mingo/cfs-scheduler/tools/hackbench.c	
GPLV2
lmbench	                                lmbench	
http://www.bitmover.com/lmbench/lmbench3.tar.gz 	
       GPLV2
tiobench	                                tiobench	
http://tiobench.sourceforge.net/	
               GPLV2
iotop ( Disk IO Monitoring)	iotop	
http://guichaz.free.fr/iotop	
                   GPLV2
procps (CPU Monitoring)	        top	
http://procps.sourceforge.net	
                    GPLV2
tar	                                        tar                	
http://www.gnu.org/software/tar/	
               GPLV2
iputils	                                ping	
http://www.skbuff.net/iputils	
                    GPLV2
			


-- 
Regards,
GeunSik Lim

--
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
