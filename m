From: Darren Hart <dvhltc@us.ibm.com>
Subject: Re: cyclic test results on 8 way (2.6.23.1-rt7 through 2.6.23.1-rt11)
Date: Thu, 8 Nov 2007 07:56:01 -0800
Message-ID: <200711080756.01502.dvhltc@us.ibm.com>
References: <200711072334.40216.dvhltc@us.ibm.com> <4732CF27.BA47.005A.0@novell.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: "RT" <linux-rt-users@vger.kernel.org>,
	"Steven Rostedt" <rostedt@goodmis.org>,
	"Thomas Gleixner" <tglx@linutronix.de>
To: "Gregory Haskins" <ghaskins@novell.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e4.ny.us.ibm.com ([32.97.182.144]:33755 "EHLO e4.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759002AbXKHP4L (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 8 Nov 2007 10:56:11 -0500
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e4.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id lA8Fu3kO007319
	for <linux-rt-users@vger.kernel.org>; Thu, 8 Nov 2007 10:56:03 -0500
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id lA8Fu3lm464368
	for <linux-rt-users@vger.kernel.org>; Thu, 8 Nov 2007 10:56:03 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id lA8Fu2HL002588
	for <linux-rt-users@vger.kernel.org>; Thu, 8 Nov 2007 10:56:03 -0500
In-Reply-To: <4732CF27.BA47.005A.0@novell.com>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thursday 08 November 2007 05:56:07 Gregory Haskins wrote:
> >>> On Thu, Nov 8, 2007 at  2:34 AM, in message
>
> <200711072334.40216.dvhltc@us.ibm.com>, Darren Hart <dvhltc@us.ibm.com> 
wrote:
> > Greg,
> >
> > Here are the results I promised you.
>
> Darren,
>    First off, thanks a bunch for running through those tests!
>
> > I don't think they are particularly interesting
>
> They *are* interesting in the sense that peaks of 40ish for an 8-way are
> excellent IMO ;)  But yeah, i see what you mean; theres no interesting
> difference between them.
>
> Do you have any comparative data from runs in -rt1 or earlier kernels?

Unfortunately no.

>
> > perhaps more iterations, say 1000000?
>
> We generally load the system up a lot more (e.g. "make -j 128")  or let it
> run for a long time with the make in a loop (or both).  For instance, here
> is the last data I gathered (with plot attached).  This was for a single
> pass of "make mrproper; make allmodconfig; time make -j 128"

I loosely based my runs off the examples here:

http://rt.wiki.kernel.org/index.php/Cyclictest

If there are a better set of "start here for cyclictest results" I would 
really like it if someone would add that to the cyclictest wiki page, 
complete with command line options, etc.  For instance I can see you ran -t 8 
below, but how many loops? with what interval? with which timer mechanism?

Thanks,

Darren

>
> 23.1-rt7
> -----------------
> real    10m49.312s
> user    49m59.674s
> sys     16m15.404s
>
> 26.38 76.02 56.11 1/304 21301
>
> T: 0 ( 5959) P:90 I:100 C:7500381 Min:      2 Act:    2 Avg:    4 Max:     
> 78 T: 1 ( 5960) P:89 I:200 C:3750191 Min:      2 Act:    3 Avg:    5 Max:  
>    91 T: 2 ( 5961) P:88 I:300 C:2500127 Min:      2 Act:    3 Avg:    4
> Max:      66 T: 3 ( 5962) P:87 I:400 C:1875096 Min:      2 Act:    5 Avg:  
>  6 Max:     106 T: 4 ( 5963) P:86 I:500 C:1500077 Min:      2 Act:    6
> Avg:    5 Max:      92 T: 5 ( 5964) P:85 I:600 C:1250064 Min:      2 Act:  
>  5 Avg:    6 Max:      93 T: 6 ( 5965) P:84 I:700 C:1071483 Min:      2
> Act:    3 Avg:    6 Max:      78 T: 7 ( 5966) P:83 I:800 C: 937548 Min:    
>  2 Act:    5 Avg:    6 Max:      97
>
> 23.1-rt10
> -----------------
>
> real    10m39.046s
> user    56m31.662s
> sys     12m51.158s
>
> 7.64 63.88 62.70 1/291 30774
>
> T: 0 (15455) P:90 I:100 C:8001856 Min:      2 Act:    3 Avg:    4 Max:     
> 65 T: 1 (15456) P:89 I:200 C:4000928 Min:      2 Act:    3 Avg:    4 Max:  
>    46 T: 2 (15457) P:88 I:300 C:2667286 Min:      2 Act:    3 Avg:    5
> Max:      54 T: 3 (15458) P:87 I:400 C:2000464 Min:      2 Act:    3 Avg:  
>  5 Max:      46 T: 4 (15459) P:86 I:500 C:1600372 Min:      2 Act:    3
> Avg:    5 Max:      46 T: 5 (15460) P:85 I:600 C:1333643 Min:      2 Act:  
>  5 Avg:    5 Max:      75 T: 6 (15461) P:84 I:700 C:1143123 Min:      2
> Act:    5 Avg:    6 Max:      52 T: 7 (15462) P:83 I:800 C:1000232 Min:    
>  2 Act:    4 Avg:    5 Max:      66
>
> 23.1-rt11
> -----------------
>
> real    10m41.610s
> user    55m37.065s
> sys     13m16.394s
>
> 101.92 101.56 61.65 1/308 21349
>
> T: 0 ( 6028) P:90 I:100 C:6584414 Min:      2 Act:    3 Avg:    4 Max:     
> 55 T: 1 ( 6029) P:89 I:200 C:3292207 Min:      2 Act:    6 Avg:    5 Max:  
>    58 T: 2 ( 6030) P:88 I:300 C:2194805 Min:      2 Act:    5 Avg:    5
> Max:      54 T: 3 ( 6031) P:87 I:400 C:1646104 Min:      2 Act:    5 Avg:  
>  5 Max:      79 T: 4 ( 6032) P:86 I:500 C:1316883 Min:      2 Act:    5
> Avg:    5 Max:      60 T: 5 ( 6033) P:85 I:600 C:1097403 Min:      2 Act:  
>  5 Avg:    6 Max:      45 T: 6 ( 6034) P:84 I:700 C: 940631 Min:      2
> Act:    3 Avg:    6 Max:      45 T: 7 ( 6035) P:83 I:800 C: 823052 Min:    
>  2 Act:    5 Avg:    6 Max:      47
>
> As Steven Rostedt pointed out on IRC, numbers coming from me are suspect
> ;).  But we can at least use them to see if you can repro similar results.
>
> Thanks again!
>
> Regards,
> -Greg



-- 
Darren Hart
IBM Linux Technology Center
Realtime Linux Team
