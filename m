Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794239274;
	b=wd8QL6kiwwErUaItgr9Lrjj2XOe4kMBG0q3YrzYLzb3ntFCNxl5laVOm/1IhuSA800AB
	 svFS/CRpuZtYJgf+5aTtbwQd00pY/FgLyODP7WChBfcvmSXrqH+z/zvdxTRObw9avU5AY
	 nY+oajXVvPyFtWl3W692IM9VVtL6gWIELYKRzRBSY7l90dqQfsf9iQB8l9/sCEFO9dCfM
	 qmdeZA6i3suYNa/jC6J0HRMqpo0YxC+NAno+vsdIPuJPuEW8r/pH4+wXLGh6zr5/ySuMO
	 rkN+cyeRS4vAYzTOQezT9vq/+8KaO5JtnVUgMNEY2vWJCfcpx4i3WBjhNBf0HS+mgNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794239274;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:Reply-To:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=XorZuwEOvBa7EvLEBlorG40GcEZpUrSdYSnIigmrxrQ=;
	b=OalwZTadx6MSjlXC7G4ZWvwnt0eqOp5ehWEJS4CcYL24Ltt4agPtfiqCFXgVPkOj2L39
	 dPBcoiLLRbH5f/9Nz6nzzPzS/6XshhAM4MXBar1DnmndLnPFhDab5k8EeDCUOsPWqOMnw
	 NhZ+NJrKpff2zt8OVjfmlP+hpeVukcTEmlJ5JXxsQ+6LsqH68RkyNHKZoKRsSGHfDcEVh
	 JgV1MLa0Mkb/KL0+MaMBcB9yEdJS0hCtLaZp+n5P3S1gaJ76duSOO8yh7LMQFUx83JETE
	 zVNCsfnGVqkBq41AXW3VjEH1iyb/X7Qs2aUavzSjbKXscOpRUieIR5E38DZOXnUZGTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DCsHDGul;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=cJvf3Dkh;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EDA0606A321
	for <linux-rt-users@vger.kernel.org>; Mon,  9 Nov 2026 15:47:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7EDA0606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DCsHDGul;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=cJvf3Dkh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794239272;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:in-reply-to:in-reply-to:  references:references;
	bh=XorZuwEOvBa7EvLEBlorG40GcEZpUrSdYSnIigmrxrQ=;
	b=DCsHDGulVVtmJPlJSmLsG3AhpSOq5EduCmaPF6WRVPTEElGs+tlPPpKwBQT3uaQbzqazED
	cUwF5NRasbLOpKoNAliLF2HDxQYhmRCHwYZSvE2CqJ+4It/fwDcDkAsmaEz9SAFOBInHIV
	FWgoQfh72SsotRVkRvv8ggFfDB0ZhuU=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-509-G1M7qG8sO_aE3EFMAcfY2A-1; Mon, 09 Nov 2026 10:47:49 -0500
X-MC-Unique: G1M7qG8sO_aE3EFMAcfY2A-1
X-Mimecast-MFC-AGG-ID: G1M7qG8sO_aE3EFMAcfY2A_1794239269
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-5364605e74bso29060631cf.3
        for <linux-rt-users@vger.kernel.org>; Mon, 09 Nov 2026 07:47:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794239269; x=1794844069; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:reply-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=XorZuwEOvBa7EvLEBlorG40GcEZpUrSdYSnIigmrxrQ=;
        b=cJvf3DkhCOKtI608aK3C0kpAYOd+PokqIwRhiMup+7r74Hv/IjoftcspDtXiNZws0F
         mnP4LKopGqbv5l/Bi50zhtkK580KESP0Yx8VimkPGk30HkcxEp11cAvdhIjk+0GDDRWS
         sMOFE65d/V98l2SeLPY8nRuVUUEj+HcmozYqQfb7TuYphEDedwTjfTFfjT25fIvotuC9
         TXOuIKQIlTf1u9G/rDW4uOYM4Ze93dgOx0iXndEILyLp0c1FtVm748iOkVgoY7hvEzLY
         VqStPAoQdnIdxfvU5HHyuxstJP2+RLjAqwdcWJ1Hi+df2dJZ+UQ3Qb7888+XF6p+nFIp
         QE7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794239269; x=1794844069;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XorZuwEOvBa7EvLEBlorG40GcEZpUrSdYSnIigmrxrQ=;
        b=ENx0Fm2Ta3p9Xh6j6GBMtKJgX3AVTqtjFp/vMVZeQ9DE2TND6fk6cBv0OT17H4jxmr
         +Z9PaTiUwliwhH+C3BHZar3b27uxoJDVNEcAW10mnqTTkzjPeXn05AIc/a7Y8qihbbhF
         wIV7ea2jqz1GXqq3Hzm6DQPL6kNPl+8h8lnUjSRtWdUCrhYsCFn7L8cfn/KwXnYn3+BI
         9lzAz4L6KzPAnPkCiFdkBin6CVSx5EoqnPsTANPxlv2PclyvvPiReKa9TYrfOY4IIoz9
         40n2P5/PVasIKmV19Co+ZuOILRWF7myRcVhI/UQu4iHipaVtB7AoVtIE9HlEeBn4BEG8
         M0Eg==
X-Gm-Message-State: APuU4Z/R9vhkHbM+oqlIMNT/Jb9Eai0oEluYnCY5njgXpE1qYtxMcEHw
	nGHUBCLsS+DMY9ydW4xETFWaHlWVdq7DUZfl75yiv+i//eeHAbwDCrHk1gaS7iSuJyFWII1fxoA
	OLLwRIV8TwwIyFFeb46XElAastWt8L9ATZs3kTnNFAtiUHiPRJ5A9TGQkueAuoS0Tf07/
X-Gm-Gg: AYBFou2yGyvNrAHp7g0kuSjqDzdW/b95DuSJYDuajHO03+GKmLZzhCt922bzaOlYi+6
	xHs/11ZBRg3UUaR9/THzF7Hph3FDMRy13GTGsGogfHnMrfsdko9PuM9eH+xuh6rU8PMIeMM6Gxh
	E+Blz1Bxbn5XEFWu4C7lYVo+9xiHnXH6PFIh+p9m4ykDm50/49JOGdZE3F4WiRIHfsYvJULyPuj
	h6vt2jwHfRsHOteZC8CCxjyuCSm2tm7lD71mWsZunETwAhREOIb2r4puPlR/DEjzVsuPgmATrGi
	Verw8mw4HxVEEkAMNeqfXPVg10eS7LdpCyx+p8UD4WpiGevsXu2btb7TxF/gkhiklRoTp+CxqtM
	7pcvah/+ghKuZr9i/Hzc6YH2+ifiXgpC3kDLy/OQOzr6HTsM3QLHApoBn3CuDNeLwwbzwSF0bzb
	c2kkm23w==
X-Received: by 2002:a05:622a:1904:b0:54f:863d:92c0 with SMTP id d75a77b69052e-552a6148a95mr72783091cf.65.1794239269133;
        Mon, 09 Nov 2026 07:47:49 -0800 (PST)
X-Received: by 2002:a05:622a:1904:b0:54f:863d:92c0 with SMTP id d75a77b69052e-552a6148a95mr72782671cf.65.1794239268634;
        Mon, 09 Nov 2026 07:47:48 -0800 (PST)
Received: from localhost (c-71-234-51-224.hsd1.ma.comcast.net. [71.234.51.224])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5550bd33340sm89621cf.21.2026.11.09.07.47.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 07:47:48 -0800 (PST)
Date: Mon, 9 Nov 2026 10:47:47 -0500
From: Sana Sharma <sansshar@redhat.com>
To: "Ahmed S. Darwish" <darwi@linutronix.de>
Cc: linux-rt-users@vger.kernel.org, jkacur@redhat.com
Subject: Re: [PATCH v1] rteval: Covering edge cases in multi-stressor support
Message-ID: <avHrIx7yc1xSE7EE@sansshar-thinkpadp1gen4i.boston.csb>
Reply-To: sansshar@redhat.com
References: <au4t5C1-WpgWChOm@sansshar-thinkpadp1gen4i.boston.csb>
 <avGz940EAsx6-GvX@lx-t490>
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Post: <mailto:linux-rt-users@vger.kernel.org>
List-Help: <mailto:linux-rt-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rt-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <avGz940EAsx6-GvX@lx-t490>

On Mon, Nov 09, 2026 at 12:52:23PM +0100, Ahmed S. Darwish wrote:
> Hi Sana,
> 
> On Fri, 06 Nov 2026, Sana Sharma wrote:
> >
> > Added a number of unit and integration tests for edga case coverage
> > Also added some logic to multi-stressor support to de-duplicate values
> > and cleans up trailing spaces and commas.
> >
> 
> For both the subject line and the changelog, please avoid passive language.
> 
> Per linux/Documentation/process/submitting-patches.rst:
> 
>   Describe your changes in imperative mood, e.g. "make xyzzy do frotz"
>   instead of "[This patch] makes xyzzy do frotz" or "[I] changed xyzzy to
>   do frotz", as if you are giving orders to the codebase to change its
>   behaviour.
> 
> I did not look into the actual patch, but in general your description text
> should've been something like:
> 
>   Subject: rteval: Cover multi-sressor edge cases
> 
>   Add unit and integration tests for better edge cases coverage.
> 
>   Add multi-stressor support for values de-duplication and stylistic
>   clean-ups.
> 
> Note the imperative language change.
>
Thank you so much for your corrections and feedback. I will incorporate 
this moving forward.

Best,
Sana Sharma
Red Hat

