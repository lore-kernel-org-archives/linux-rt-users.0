From: Hinko Kocevar <hinko.kocevar@i-tech.si>
Subject: Re: Poor cycletest results for rt6
Date: Fri, 29 Jul 2011 16:33:22 +0200
Message-ID: <4E32C4B2.2000705@i-tech.si>
References: <4E329515.7080803@i-tech.si>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.i-tech.si ([89.212.78.105]:32181 "EHLO mail.i-tech.si"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751187Ab1G2OdY (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 29 Jul 2011 10:33:24 -0400
In-Reply-To: <4E329515.7080803@i-tech.si>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 07/29/2011 01:10 PM, Hinko Kocevar wrote:
> Hi,
>
> I've build linux-3.0-rt6 for my ARM platform (XCEP). Running cycletest
> on vanilla, preempt and rt6 kernel build reviles the following results.
> I would expect better rt6 performance.
>
> Note that last test actually looks quite promising, but it happened once
> in 5 test runs :(

Mike Galbraith pointed me into the right direction with the heads up 
about the ksoftirqd/0 process that hogged the CPU for a short moment, 
enough to make cycletest 'Max' column numbers high.

Reading some googled results about the ksoftirqd made me suspicious 
about the network traffic 
-http://www.gossamer-threads.com/lists/quagga/dev/17725

Since I'm running my board of the NFS rootfs I opted for using -q switch 
with the cycletest. The result was 5/5 test runs with best 'Max' column :)

$ ssh root@192.168.11.132 /shared/utils/cyclictest -t 10 -p 80 -n -D 30 -q
WARNING: Most functions require kernel 2.6
T: 0 (  707) P:80 I:1000 C:  29001 Min:     16 Act:  129 Avg:  203 Max: 
     504
T: 1 (  708) P:79 I:1500 C:  19333 Min:     16 Act:  217 Avg:  204 Max: 
     602
T: 2 (  709) P:78 I:2000 C:  14500 Min:     16 Act:   89 Avg:  163 Max: 
     575
T: 3 (  710) P:77 I:2500 C:  11600 Min:     16 Act:  195 Avg:  222 Max: 
     590
T: 4 (  711) P:76 I:3000 C:   9666 Min:     16 Act:  395 Avg:  358 Max: 
     697
T: 5 (  712) P:75 I:3500 C:   8285 Min:     16 Act:  115 Avg:  263 Max: 
     767
T: 6 (  713) P:74 I:4000 C:   7249 Min:     16 Act:  265 Avg:  262 Max: 
     637
T: 7 (  714) P:73 I:4500 C:   6443 Min:     17 Act:   74 Avg:  220 Max: 
     734
T: 8 (  715) P:72 I:5000 C:   5797 Min:     17 Act:  353 Avg:  294 Max: 
     730
T: 9 (  716) P:71 I:5500 C:   5264 Min:     18 Act:  207 Avg:  264 Max: 
     696



-- 
Hinko Kocevar
