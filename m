Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15DF519D09F
	for <linux-rt-users@vger.kernel.org>; Fri, 16 Aug 2024 14:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723817288; cv=none; b=jRFXTF0Cq6bOx8fCIQT7BKUFvr2ULuLi3Sa4oCjA+52iz/Qq+5n8P8Q6+q0zagLVn32sdzIEdHMGy/bRtDiVZSOSoq+78RFS6t9B8rEycYdopyCmE9JMt6UhCTzNqV4BcGvLK/VoWr5W7DIZqzSfj6IXxKqrXcaGQN9J/azPIE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723817288; c=relaxed/simple;
	bh=z0E4boA8Ubzi/IDtvrQJ9e5vxDNuygZ5ugwb4QcFm/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ebWBfQ7ymKoTa3WieO/M2vy5JRRKNidS6LwUsa7659aZHJZzf3njVhSPATDUvBoFbmVuIR+incPWXBIF2aaxkhSc5b2wZVY4zsEE8gTOGthus428EQ+thNqpcGiMtNZYhP2ZbT4kLjYUeGFI3Zj4AIMdJEoMPYCkh416Wbs3qsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ly4tL/Hi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ly4tL/Hi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34465C32782;
	Fri, 16 Aug 2024 14:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723817287;
	bh=z0E4boA8Ubzi/IDtvrQJ9e5vxDNuygZ5ugwb4QcFm/A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ly4tL/HiUNnBkVVOg8gPfz6QWK9GKrqvhqMTwZk6P6S9g8GsgDUhf+2Tdo3khVENP
	 egZ9bB4+s9rh3bjCppa9KVbgJ6H7avKaE/eSf9+/V2mi6CP3AsWrnN55R+LkKYmRD6
	 gZNdeUPLNd/MPPBJ31ic4JWCNXPVSeU615cO+d4vUeZ4NTanM/Pbu7SZIrAVGYLnjc
	 LDtrg67PcMMhNNMr3PYvMmhKQQMjuJxR5fdBJKI0RmyGfdsEpT6A4m5b9RfwsY8fnj
	 YLp9EC7sjJAO9lscvEb/DNY6n0BiyAMemBTB2zKscN20j8NWK/EvfpM3beKeIR3xh4
	 z94WMEMvVCpdQ==
Date: Fri, 16 Aug 2024 16:08:04 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Leon Woestenberg <leon@sidebranch.com>
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: rcuc/ thread on isolated CPU
Message-ID: <Zr9dRNz7J2XDcyu0@pavilion.home>
References: <CAMjhiJiqfz67Aba8KAKTHjO7TjGADvM2S0qDVrGfF+XkT5DeAw@mail.gmail.com>
 <CAFTL4hws_4D2-ez+TkGZU5ZWUys=yqmAjxiQa52K6zXwe6nqMA@mail.gmail.com>
 <CAMjhiJhZQvr1qEdUm3T2v=JDETO4iWjjo5Lfc=XQgkm4yPwXtg@mail.gmail.com>
 <CAMjhiJhzwBKGYGKEdsiZjaiPDPE5mz=hazV2dS-THcUKHsDSUA@mail.gmail.com>
 <CAMjhiJg579K25DAahfqcpMjbtVqk2uie80-wevnX09CpbcxC0w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMjhiJg579K25DAahfqcpMjbtVqk2uie80-wevnX09CpbcxC0w@mail.gmail.com>

Le Tue, Aug 13, 2024 at 04:34:44PM +0200, Leon Woestenberg a écrit :
> Hi all,
> 
> On Wed, Jul 24, 2024 at 5:30 PM Leon Woestenberg <leon@sidebranch.com> wrote:
> > On Wed, Jul 24, 2024 at 4:46 PM Leon Woestenberg <leon@sidebranch.com> wrote:
> > > On Wed, Jul 24, 2024 at 4:35 PM Frederic Weisbecker <frederic@kernel.org> wrote:
> > > >
> > > > Le mer. 24 juil. 2024 à 16:06, Leon Woestenberg <leon@sidebranch.com> a écrit :
> > > > > CPUs." and also tried with rcutree.nohz_full_patience_delay=1000.
> > > > Are you sure you have the proper patch applied? It is not yet upstream:
> > > >
> > With the patch installed and adding kernel command option
> > rcutree.nocb_patience_delay=1000 I can still get rcuc to run on the
> > isolated #4.
> >
> 
> Is this issue a specific regression, i.e. is there a kernel version
> that does not show the behaviour that this patch tries to resolve?

I'm not sure. Can you reproduce this without PREEMPT_RT patch?

Thanks.

> Regards,
> 
> Leon.
