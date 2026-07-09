Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332A842669C;
	Thu,  9 Jul 2026 16:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783612945; cv=none; b=TTX5jU/+KADZooEVCIy1f6cRt/n6furItoshsjlCgrFsILBZIsgoZ5LMifBlfmGIMkXLalQbMqgLSsMbW+kOGsqhepv7XkOJAXAy1rMv6TOY3Z1IAULugcKkAvJUgpdUzYzLrxn4Uf4rIgipBTVvWeCUst9ZumWjjnolEsR0n54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783612945; c=relaxed/simple;
	bh=yPRjF3TD3+zUJQSXqDWx38rnAPzsS2sPSwNj5z+j6vc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FsJI3f0t4vENCj+Qatasq8ZTJnTxr37eQItXkFWDbBeM9seYUgi6vgwEN0KOGtEuEGB2fkZQpQo37wF4L7VJ5dWqiLeca76YQEVzIfqQTSaMCUrQQah5U+H0SCGH/nDOu85Ix22ijFln88anUqTK70cZp/32AIZpZB/C5upmgDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C5311F000E9;
	Thu,  9 Jul 2026 16:02:23 +0000 (UTC)
Date: Thu, 9 Jul 2026 11:02:22 -0500
From: Clark Williams <williams@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	driver-core@lists.linux.dev, linux-rt-devel@lists.linux.dev,
	linux-rt-users@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Danilo Krummrich <dakr@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC PATCH] sysfs: Add /sys/kernel/realtime entry
Message-ID: <ak_GDsJS6kVoUM2f@lysander>
References: <20260709143108.UYeCUUcd@linutronix.de>
 <2026070922-kilowatt-matador-5e1c@gregkh>
 <20260709152214.rH1O_8SM@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260709152214.rH1O_8SM@linutronix.de>

On Thu, Jul 09, 2026 at 05:22:14PM +0200, Sebastian Andrzej Siewior wrote:
> > But really, why is this needed?  Userspace shouldn't care, right?
> 
> So there is Clark who needed it 15y ago for some udev rules. Maybe he
> elaborate on that.
> 

Ugh, I've always been embarrassed about that patch. We added it because
in the dim dark past, something triggered udev many, many times and that
called a shell script which searched the 'uname -v' output for
PREEMPT_RT, meaning boot times slowed to a crawl. Instead we added 
/sys/kernel/realtime and it just became a stat(2) call to see if the
file existed. Pretty sure that was a RHEL6 kernel (2.6.32-ish) and I
suspect that the need for it is long gone. 

I'm hesitant to call for it's removal, because the only other way for
startup code that want's to know if it's on a realtime kernel is to look
for PREEMPT_RT in the 'uname -v' output. I know that the financials and
the telcos tune specifically for RT, pretty sure there are others. 

> There is custom "software" that is designed for realtime environment and
> if it is run on a regular kernel then it missed its timing requirements
> and the software goes usually in a fail state and people start debugging
> what has happen. If this happens often enough (booting a non-RT kernel)
> they tend to add a check so that the software complains early enough
> since checking the kernel is usually the last thing that is done.
> 
> This could work with the file (or folder) or by parsing uname output. I
> know of at least two individuals that switched to uname because the
> upstream RT does not have that file.
> 

Really? We always took the absence of that file to mean Not Realtime.

> cyclictest (from rt-tests) is using this file but only while collecting
> system information, nothing else.
> 	https://git.kernel.org/pub/scm/utils/rt-tests/rt-tests.git/tree/src/lib/rt-utils.c#n528

I'll ask around, but I'm betting RTLA checks for this as well. 

> 
> There is also sosreport
> 	https://github.com/sosreport/sos/blob/main/sos/report/plugins/kernelrt.py#L32
> 

Forgot about sosreport.

> using for information collection purpose.
> There is thermald
> 	https://github.com/intel/thermal_daemon/blob/master/src/thd_engine.cpp#L1065
> but this looks like just information gathering. That check looks wrong
> since there is a space instead of an underline in the check so this was
> not tested on a RT kernel.
> 
> > And checkpatch should complain about the sprintf(), should be
> > sysfs_emit().
> 
> Sure.

I can certainly fix that.

The question I have is, would a folder with RT-specific information be useful? 
Someone just wanting to know if they're on RT could still check for existance
if that's all they want to know, but I'm not really coming up with any
other information that would prove useful for someone tuning for an RT
workload. 

Is there a "better" way to indicate that the system is running a
PREEMPT_RT kernel?

Clark

-- 
The United States Coast Guard
Ruining Natural Selection since 1790
