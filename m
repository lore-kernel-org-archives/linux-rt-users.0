Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAAF833FE05;
	Thu, 26 Mar 2026 14:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774536764; cv=none; b=EGjg4pzKBBQ+qqFFODJebExJPAGFnJyIxaj0iP/0PjcsYOq3V3XdE3PCvwqOhO7lprTiu2RwO379/P2Jx1FHQFQmhUFRv2sOlPoYCdLOPPCtqiNrxyxSp5WXu5qPWwRlErSsCLJC6bQYzrW9oxCF8pEX9blgl/WfAbE0KqXLSMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774536764; c=relaxed/simple;
	bh=WWp2J6XEblP+dVnCSqcs3bjGAghEOzaXbJK75udXCrE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BVYyGUET+TT+I4wQDs6aCVgB53XSW3kXliaUNIfKIBiblCqb4QsM/36YEtVhWzwhHvSiM4Rnrb+tv4NN0X4M+sBH5KlYivWx0E1k7RGw82or8OdqReEEwHLZo5MBCKggSchgMUQM9qMgBY6KdampMod7xkIz0Szz9KGk9ZtVe14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iHDQwHCk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iHDQwHCk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2727C116C6;
	Thu, 26 Mar 2026 14:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774536764;
	bh=WWp2J6XEblP+dVnCSqcs3bjGAghEOzaXbJK75udXCrE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iHDQwHCkYXvFmUYaEea9ADnaYtKR0Wl5Y31qShiPcnpVQVI6o5CiWvDopFwhRtuHc
	 EQMF0GXstN1oiioWXQNpbTjnL3QdOR03KmFZwgWTOCGCPye6cKVbo4sIbg/6JwXklW
	 bKvN45Gi+k3k2cxyG5G2s6Lv1QEoxd37A/pbpTa4=
Date: Thu, 26 Mar 2026 15:52:20 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
Cc: namcao@linutronix.de, brauner@kernel.org, linux-fsdevel@vger.kernel.org,
	linux-rt-users@vger.kernel.org, stable@vger.kernel.org,
	linux-kernel@vger.kernel.org, frederic@kernel.org,
	vschneid@redhat.com, chris.friesen@windriver.com,
	viorel-catalin.rapiteanu@windriver.com, iulian.mocanu@windriver.com
Subject: Re: [REGRESSION] =?iso-8859-1?Q?osnoise=3A?=
 =?iso-8859-1?Q?_=22eventpoll=3A_Replace_rwlock_with_spinlock=22_causes_~5?=
 =?iso-8859-1?B?MLVz?= noise spikes on isolated PREEMPT_RT cores
Message-ID: <2026032640-gangly-sprout-099b@gregkh>
References: <20260326140058.272854-1-ionut.nechita@windriver.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260326140058.272854-1-ionut.nechita@windriver.com>

On Thu, Mar 26, 2026 at 04:00:57PM +0200, Ionut Nechita (Wind River) wrote:
> Hi,
> 
> I'm reporting a regression introduced by commit 0c43094f8cc9
> ("eventpoll: Replace rwlock with spinlock"), backported to stable 6.12.y.

Does this regression also show up in the 6.18 release and newer?  If so,
please work to address it there first, as that is where it needs to be
handled first.

thanks,

greg k-h
