Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938CF2DF153
	for <linux-rt-users@vger.kernel.org>; Tue, 19 May 2026 16:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779207549; cv=none; b=HFvZqtfx989YuZbbXkjUkxD7oj2t23CavYf8hySEiC3OXM3szw+hbpJLQDigKQ5+G8vYHC4T4eRMcIvwhbBPCf3pXqkTsK7qQXIWS4K05IqWkydFIWVHO1Sjh1NCFZ4/74TuS4tBUdfwfGi/jgrjW7+dVEzwTes7itESgTY+N/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779207549; c=relaxed/simple;
	bh=V2cyGsvcEK1A9SLy9blLw02kY04LB0hI5Dbx6JNWWqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ni8psRluDw+m9eLqEQzWomSPXNGiJyQNql39Iz9XXCVTn/HtV9edXUobKaMwN6DlMfrg9Swl/vaspIDmkHDlMQObGciYGJopvlR3OG+SgZOjn7UWbej9Bp+Y3f+OnvMmnvpfAh/qNvUafOa8TiV9lw3YVkuoPVFvuPRnZJu2630=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wbinvd.org; spf=pass smtp.mailfrom=wbinvd.org; dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b=FEO8UiPp; arc=none smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b="FEO8UiPp"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-12c1a170a50so4662112c88.0
        for <linux-rt-users@vger.kernel.org>; Tue, 19 May 2026 09:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wbinvd.org; s=wbinvd; t=1779207547; x=1779812347; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=khVqO4Z4rE2qwk5253J5JQWCckznW2vJhR2BBG4hqrU=;
        b=FEO8UiPpVqgun7PW9wMXbBtzIHkMgX+n8MdnBejqNXw4geIigtt1XydF2MLv9dSvqB
         A4ylLh6xucP0oiq3akYD6St2s92WZnGtv6kgvm76M3o4GCT0MUMAw87BIh03NUgvAnl4
         7VjY6SA47Y/mCuQ/Hvd/289pWc8GV3tDwqrESsrvYE/i35dKezbLpwCjCh4aUbW5GSGA
         PFKafQY0r5+6KPfm2qTb5lelBMU4FjZAQgVEhKtkS6PngU/rK3bnTyEM8J4rsGWXrCj1
         syxGNbRphulZdGbMfJ93ie4HaO53stnlOu1GCmTzCBbmhfa6vFtW9lLl4HHnH3g0AYt2
         DrVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779207547; x=1779812347;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=khVqO4Z4rE2qwk5253J5JQWCckznW2vJhR2BBG4hqrU=;
        b=VouREwUox/IEpMb/T26PErubwzLQ9CI7f137QFXeepU66XgkqlAod78HSB25hH83eh
         EyCrJKJAU6yzMmOUPI7tzy/4PGiv0V+HM5fjR8ewCSWQ3CXa4imF4/E1MVnPTlfndJxQ
         iH2R6+eDwzb8Onr60BZ81unX1n1IU7LPiIaTeYJzwyBkn92SPiLmu4zd/DYZtaigey7y
         aOCojm+eGggBLbJ26hF2BUVWCFlt+qKklTpQ34C8eBCodYnjksm9kYJtUSt0MocTMlw8
         CkcfXjHLHLzJPznIS4kWsaSiu3H9pcXqzF21Xs9w0b/wu4u65FJsTEtIGSN5XTSm7BSZ
         UObg==
X-Forwarded-Encrypted: i=1; AFNElJ9bzStHVYWNK9vtLiWLu9kJk8y/FMyuB/ww9pTP/FsRDjVcdMuiWDuRI512vllU8Q4FeQ2Ougi3VzaX1oQPAA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwS+941AZwo96348AU4hO6kcxx9nJMi3wj02EZkTFJNSBKjXP1P
	tG0HIaog4DL3IdO39CPhCTbPgsc4urIPp1ocX46sbzYt4TxjgVyhr7slyD0SOIW+k30=
X-Gm-Gg: Acq92OHJWtOYrOE72EWEvoRf9db7KnfyNDEjdZlRWnV2sZVmV1QaK8seprh9PDkuurC
	CVnWbYzao0C80CdobRolUrJHDfyPK2DCwx3qeL1MT8V31BGZr3gfUDasaD9kdYk2Tn6HBI6fdRT
	S4Sb6tN8JQ2EVazEogjI9WT/KNUC7lym9aevMuFKGGeyvSMCJDFjG24BM1tEm8yK4dCbnfSF13y
	sPcsy0BTqe+rg7thwG7jSFPQCIJR3zG96JghclT7IVm1nuQAEPSnfkRsTVVAnCn6aPSkKKsxp3C
	rkFxtOX49uwHDc6kSuDxIHgvuClAPr/YKVWwke04rky3GNmfw1cMyP2FHPLvNCdU6J/MYLHg6Qe
	0CxaLN7x4SGgU6KoJ2hzVhR9hjq4RtJdNftv3/MAubHP86G4STvv9gfm2HhCM0G68Uf4fMBuZtx
	ZPzwODQakJSznW5UBbPwEOA2SaaQ==
X-Received: by 2002:a05:7022:60b:b0:134:feba:3b7 with SMTP id a92af1059eb24-13504945c88mr9493469c88.31.1779207546533;
        Tue, 19 May 2026 09:19:06 -0700 (PDT)
Received: from mozart.vkv.me ([2001:5a8:468b:d015:607b:660e:b0bc:f251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30293e2e69esm21132953eec.1.2026.05.19.09.19.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 09:19:06 -0700 (PDT)
Date: Tue, 19 May 2026 09:19:03 -0700
From: Calvin Owens <calvin@wbinvd.org>
To: Michael Byczkowski <by@by-online.de>
Cc: Rodolfo Giometti <giometti@enneenne.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	bigeasy@linutronix.de
Subject: Re: [PATCH v5 0/3] pps: improve PREEMPT_RT performance
Message-ID: <agyNd1SsQlmaL3mh@mozart.vkv.me>
References: <719A31CE-CA58-45C3-A013-1BFE81F724C5@by-online.de>
 <5FDC46CF-4F8F-4E85-9E59-B796C5BF1194@by-online.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5FDC46CF-4F8F-4E85-9E59-B796C5BF1194@by-online.de>

On Saturday 05/16 at 13:32 +0200, Michael Byczkowski wrote:
> > On 25. Apr 2026, at 19:18, Michael Byczkowski <by@by-online.de> wrote:
> >
> > I found three issues in the PPS subsystem that cause unnecessary jitter
> > under PREEMPT_RT, while being fully backward-compatible with non-RT
> > kernels:
> > 
> > 1. pps-gpio: The IRQ handler is force-threaded on PREEMPT_RT, so the
> > PPS timestamp is captured after scheduling delay rather than at
> > interrupt entry. Fix: split into a hardirq primary handler (captures
> > timestamp only) and a threaded handler (processes the event).
> > 
> > 2. pps_device.lock: spinlock_t becomes a sleeping mutex on PREEMPT_RT,
> > allowing pps_event() to be preempted mid-update. Fix: convert to
> > raw_spinlock_t and move sleeping calls out of the critical section.
> > 
> > 3. pps_kc_hardpps_lock: Same issue as (2), in the kernel consumer path
> > that calls hardpps(). Fix: convert to DEFINE_RAW_SPINLOCK.
> > 
> > All three patches are tested on a Raspberry Pi 5 running a 7.0.0-rc6
> > PREEMPT_RT kernel. On non-RT kernels there is zero behavioral change.
> > 
> > Signed-off-by: Michael Byczkowski <by@by-online.de>
> > Acked-by: Rodolfo Giometti <giometti@enneenne.com>
> > Tested-by: Michael Byczkowski <by@by-online.de>
> > 
> > by (3):
> > pps: pps-gpio: split IRQ handler into hardirq and threaded parts
> > pps: convert pps_device lock to raw_spinlock for PREEMPT_RT
> > pps: convert pps_kc_hardpps_lock to raw_spinlock for PREEMPT_RT
> > 
> > drivers/pps/clients/pps-gpio.c | 37 +++++++++++++++++++++++-----------
> > drivers/pps/kapi.c             | 18 ++++++++++-------
> > drivers/pps/kc.c               | 22 ++++++++++----------
> > drivers/pps/pps.c              | 16 +++++++--------
> > include/linux/pps_kernel.h     |  2 +-
> > 5 files changed, 56 insertions(+), 39 deletions(-)
> > 
> > -- 
> > 2.47.3
>
> Gentle ping on this series. v4 patches 1/3 and 3/3 carried Rodolfo's
> Acked-by; v5 addressed the remaining feedback on 2/3. Happy to rework
> anything or split the series if that helps it move forward.

Unfortunately apple mail is corrupting your patches :/

Greg KH usually applies patches for drivers/pps/, but I didn't add him
here yet because the patches don't apply.

If you can point me at a git branch for v5, I'd be happy to re-send the
patches myself with your authorship. This is all useful for me and I'd
like to help :)

If you do it yourself, just make sure to add Greg to the Cc: list.

Cheers,
Calvin

> Adding linux-rt-users@ and Sebastian on Cc in case there's interest from the
> PREEMPT_RT side.
