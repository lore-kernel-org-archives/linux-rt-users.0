From: ankita@in.ibm.com (Ankita Garg)
Subject: Re: High 50us+ latencies in the process signal handling path
Date: Fri, 19 Oct 2007 11:58:07 +0530
Message-ID: <20071019062807.GA10260@in.ibm.com>
References: <20071018124827.GA22282@in.ibm.com> <20071018.055242.115933276.davem@davemloft.net> <20071018132614.GB22282@in.ibm.com> <20071018153618.GI12471@unix.sh>
Reply-To: Ankita Garg <ankita@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Miller <davem@davemloft.net>, linux-rt-users@vger.kernel.org,
	rostedt@goodmis.org, ghaskins@novell.com, mingo@elte.hu,
	dino@in.ibm.com, dvhltc@us.ibm.com, kravetz@us.ibm.com
To: "Luis Claudio R. Goncalves" <lclaudio@uudg.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from E23SMTP03.au.ibm.com ([202.81.18.172]:54823 "EHLO
	e23smtp03.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754381AbXJSG2r (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 19 Oct 2007 02:28:47 -0400
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.18.234])
	by e23smtp03.au.ibm.com (8.13.1/8.13.1) with ESMTP id l9J6Se3S011131
	for <linux-rt-users@vger.kernel.org>; Fri, 19 Oct 2007 16:28:40 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id l9J6SfeT1294352
	for <linux-rt-users@vger.kernel.org>; Fri, 19 Oct 2007 16:28:41 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l9J6SOiG008580
	for <linux-rt-users@vger.kernel.org>; Fri, 19 Oct 2007 16:28:26 +1000
Content-Disposition: inline
In-Reply-To: <20071018153618.GI12471@unix.sh>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi,

On Thu, Oct 18, 2007 at 11:36:18AM -0400, Luis Claudio R. Goncalves wrote:
> Ankita,
> 
> On Thu, Oct 18, 2007 at 06:56:14PM +0530, Ankita Garg wrote:
> | Hi David,
> | 
> | On Thu, Oct 18, 2007 at 05:52:42AM -0700, David Miller wrote:
> | > From: ankita@in.ibm.com (Ankita Garg)
> | > Date: Thu, 18 Oct 2007 18:18:27 +0530
> | > 
> | > > Any thoughts on where in the code could these large latencies be
> | > > attributed to?
> | > 
> | > If the max latency is usually the first one, it's could be the page
> | > fault the signal handler is taking the first time it is executed.
> | 
> | Thanks for looking into this. Attaching the entire log from the testrun.
> | It indicates that in each run of the 10000 iterations, there are about 100+
> | failures, with large iterations. Also, on intrumenting the testcode to
> | find out the iterations which see large latencies, I see that as the
> | number of iterations increase, the latencies increase.
> 
> You might wanna check signaltest:
> 
> git clone git://git.kernel.org/pub/scm/linux/kernel/git/tglx/rt-tests.git rt-tests
>

Are any previous logs available for signaltest? This is what I get on 2.6.23-rt1-

# ./signaltest -q -p 85 -l100000 -t8
T: 0 ( 6791) P:85 C: 100000 Min:    109 Act:  148 Avg:  143 Max:     252
T: 1 ( 6792) P:85 C: 100000 Min:    109 Act:  148 Avg:  769 Max:   10240
T: 2 ( 6793) P:85 C: 100000 Min:    109 Act:  148 Avg:  769 Max:   10247
T: 3 ( 6794) P:85 C: 100000 Min:    109 Act:  161 Avg:  769 Max:   10238
T: 4 ( 6795) P:85 C: 100000 Min:    109 Act:  183 Avg:  769 Max:   10238
T: 5 ( 6796) P:85 C: 100000 Min:    109 Act:  214 Avg:  769 Max:   10239
T: 6 ( 6797) P:85 C: 100000 Min:    109 Act:  236 Avg:  769 Max:   10237
T: 7 ( 6798) P:85 C: 100000 Min:    109 Act:  329 Avg:  769 Max:   10238

And this on 2.6.21.4-rt10-

# ./signaltest -q -p 85 -l100000 -t8
T: 0 ( 3767) P:85 C: 100000 Min:     56 Act:  101 Avg:   99 Max:     162
T: 1 ( 3768) P:85 C: 100000 Min:     56 Act:  101 Avg:  725 Max:   10164
T: 2 ( 3769) P:85 C: 100000 Min:     56 Act:  101 Avg:  725 Max:   10164
T: 3 ( 3770) P:85 C: 100000 Min:     56 Act:  102 Avg:  725 Max:   10164
T: 4 ( 3771) P:85 C: 100000 Min:     56 Act:  111 Avg:  725 Max:   10165
T: 5 ( 3772) P:85 C: 100000 Min:     56 Act:  120 Avg:  725 Max:   10163
T: 6 ( 3773) P:85 C: 100000 Min:     56 Act:  135 Avg:  725 Max:   10164
T: 7 ( 3774) P:85 C: 100000 Min:     56 Act:  178 Avg:  725 Max:   10165

The values seem rather high!
 
> Regards,
> Luis
> -- 
> [ Luis Claudio R. Goncalves                    Bass - Gospel - RT ]
> [ Fingerprint: 4FDD B8C4 3C59 34BD 8BE9  2696 7203 D980 A448 C8F8 ]
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Regards,
Ankita Garg (ankita@in.ibm.com)
Linux Technology Center
IBM India Systems & Technology Labs, 
Bangalore, India   
