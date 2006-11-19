From: Dave Sperry <dave_sperry@ieee.nospam.dot.org>
Subject: RT Patch set, SystemTap, tcp test fails
Date: Sun, 19 Nov 2006 06:12:21 -0500
Message-ID: <1163934741.6306.20.camel@fc6-rt>
Reply-To: dave_sperry@ieee.nospam.dot.org
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from rwcrmhc11.comcast.net ([216.148.227.151]:25070 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S1756573AbWKSLMY (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 19 Nov 2006 06:12:24 -0500
To: systemtap@sources.redhat.com, linux-rt-users@vger.kernel.org
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi I'm trying to get systemtap to work with Ingo Molnar's RT patch set
and have run into a few problems. My test setup is a dual Xeon IBM
intellistation with fc6 and 2.6.18-rt7 #1 SMP PREEMPT.

Running the last systemtap snapshot I get the results


                === systemtap Summary ===

# of expected passes            147
# of unexpected failures        4
# of expected failures          116
# of unknown successes          2
# of known failures             3
# of untested testcases         74

The the tcp test fails because the symbol HRTIMER_REL cannot be found.
detail for the tcp tests is.

 /home/sperryd/kernels/systap18rt7/src/testsuite/buildok/tcp_test.stp
-vvvv

 probe_1509 probe_1511 probe_1512 enter_kprobe_probe
enter_kretprobe_probe enter_hrtimer_probe systemtap_module_init
/tmp/stapc3sTb9/stap_638ce45d23c34f17540fb6c3ee1929a7_3720.c: In
function 'systemtap_module_init':
/tmp/stapc3sTb9/stap_638ce45d23c34f17540fb6c3ee1929a7_3720.c:1544:
error: 'HRTIMER_REL' undeclared (first use in this function)
/tmp/stapc3sTb9/stap_638ce45d23c34f17540fb6c3ee1929a7_3720.c:1544:
error: (Each undeclared identifier is reported only once
/tmp/stapc3sTb9/stap_638ce45d23c34f17540fb6c3ee1929a7_3720.c:1544:
error: for each function it appears in.)
cc1: warnings being treated as errors
/tmp/stapc3sTb9/stap_638ce45d23c34f17540fb6c3ee1929a7_3720.c:1545:
warning: assignment from incompatible pointer type
 systemtap_module_exit probe_start probe_exit __check_send_bytes
__check_recv_bytes __check_ports __check_rtos __check_state __check_mss
__check_ssthresh __check_cwnd


Is there a way to make systemtap RT aware?

Thanks
Dave


