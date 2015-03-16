From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: 3.18.9-rt4 kernel panic - Was: 3.18.9-rt4
Date: Mon, 16 Mar 2015 17:23:48 +0100
Message-ID: <20150316162348.GC28130@linutronix.de>
References: <20150313223041.0a8bf390@archlinux>
 <20150314104336.756a6f0e@archlinux>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt users <linux-rt-users@vger.kernel.org>
To: Ralf Mardorf <ralf.mardorf@rocketmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:36431 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935458AbbCPQXu (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 16 Mar 2015 12:23:50 -0400
Content-Disposition: inline
In-Reply-To: <20150314104336.756a6f0e@archlinux>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Ralf Mardorf | 2015-03-14 10:43:36 [+0100]:

>On Fri, 13 Mar 2015 22:30:41 +0100, Ralf Mardorf wrote:
>>all kernels >= 3.14.34-rt31 I tested, don't finish startup on my
>>machine [1]. This are the last messages of startups for 4 different
>>startups for 3.18.9-rt4.
>>
>>Picture URLs:
>>http://picpaste.com/3.18.9-rt4.x86_64.end_of_startup_2.jpg

here we have
 powernowk8_target_fn() -> transition_frequency_fidvid() and then at the
end:
 932         policy = cpufreq_cpu_get(smp_processor_id());
 933         cpufreq_cpu_put(policy);

and I think the explosion starts in cpufreq_cpu_put() because I have no
idea why page_fault() shows up in the backtrace.

>>http://picpaste.com/3.18.9-rt4.x86_64.end_of_startup_3.jpg
some timer thingy, most likely follow-up

>>http://picpaste.com/3.18.9-rt4.x86_64.end_of_startup_4.jpg
looks like _2

>>http://picpaste.com/3.18.9-rt4.x86_64.end_of_startup_5.jpg
follow up

>>
>>The last kernel I tested that does work is 3.14.28-rt25.

>Picture URL:
>http://picpaste.com/3.18.9-rt4.x86_64.end_of_startup_6.jpg
dunno. 

I assume the crash occurs because cpufreq_cpu_put() returns a NULL
pointer. I have no idea why this happens or if it happens at all.
What happens if you apply this:

diff --git a/drivers/cpufreq/powernow-k8.c b/drivers/cpufreq/powernow-k8.c
index f9ce7e4bf0fe..ddf3a9006339 100644
--- a/drivers/cpufreq/powernow-k8.c
+++ b/drivers/cpufreq/powernow-k8.c
@@ -930,7 +930,8 @@ static int transition_frequency_fidvid(struct powernow_k8_data *data,
 	freqs.new = find_khz_freq_from_fid(fid);
 
 	policy = cpufreq_cpu_get(smp_processor_id());
-	cpufreq_cpu_put(policy);
+	if (policy)
+		cpufreq_cpu_put(policy);
 
 	cpufreq_freq_transition_begin(policy, &freqs);
 	res = transition_fid_vid(data, fid, vid);

>Regards,
>Ralf

Sebastian
