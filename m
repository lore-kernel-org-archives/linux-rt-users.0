Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B9B34DCE6
	for <linux-rt-users@vger.kernel.org>; Fri, 17 Oct 2025 13:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760706961; cv=none; b=luShSgN8tetpVx6wB7YDC2McnkewS/iUG6UdxClFrLo1bW9TZtBr4kMjnSHiF+2LbjkiQcCqXKxuOOMJEnxR1SumZpLMNxztAl5SpjSd/zW0BTfjak4C9lnHc0i0wFMrP68GpKfzIGomchfiJ6LOokTcsIW1uWlE8hq3DGzw0tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760706961; c=relaxed/simple;
	bh=GdiPUPH8UP/IHQEZnHyX3nIMzFN7qEzecyU82lJa+Dk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SaZ5DHRqK7wmTP/avLbO611vmGqBmWDkl/vfA7tGP8gus1J5e6Q0ZH026sHYPHF4Mjjvm3x0ZFMq7axR4kquwk0Tp5YaJCe4d7IbK2LsdiKR7MDiJE67o3XTZtWT1dPK3/M+YgJbC96wZzv9w5pelSH+DGr+AONSJ3Wzijhqbt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G++dXgLH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G++dXgLH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F4E3C4CEE7;
	Fri, 17 Oct 2025 13:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760706961;
	bh=GdiPUPH8UP/IHQEZnHyX3nIMzFN7qEzecyU82lJa+Dk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G++dXgLHdB8DRsrjbOqOl78Che4Aep6TE4cZggVDnjwNlBWLKZbPRZ6dZ2VlTatHV
	 JeV0FnKqrMQqgFqoVISJyqVK62BclL36N27rcu5BdR0/kV4F2ei67S03AeglSSEje/
	 1J50/fX7L0REjEiAljTBCr//7fS47Tv3r8CvFxe3PMyxbONZ3rWT5UN+qFvellRtrZ
	 QvwD5/XopIJa9jXhhMowLPICufxvJnHCIUr49BA1aPrnu2QicX7g0bbMczVbdU4j6Z
	 s+GbPqy7YFefylUvpAhNR3MEQUD+1tid+SjhYkaFyvCjDP18Pdfq1V4dNv/IKrmjeA
	 NK8wKOWQkwAVg==
Date: Fri, 17 Oct 2025 08:16:00 -0500
From: Clark Williams <clrkwllms@kernel.org>
To: Derek Barbosa <debarbos@redhat.com>
Cc: Crystal Wood <crwood@redhat.com>, linux-rt-users@vger.kernel.org,
	wander@redhat.com
Subject: Re: [PATCH 2/3] Makefile: Add support for legacy kernels
Message-ID: <aPJBkImjwb_Ze6dX@lysander>
References: <20251002205515.1299816-1-debarbos@redhat.com>
 <20251002205515.1299816-3-debarbos@redhat.com>
 <adb796e86ac3cd19b55ee399662b8ad97dc2bba1.camel@redhat.com>
 <cyk7iyu5rn72ppngwax6xn2nzgsyl5x2w5xjwj5aowmcw2ximv@cpxbkerjod3s>
 <6eef31238e5c8ee18fee7dbc1cf250bd30892941.camel@redhat.com>
 <6wtktjmptvddkeo3wibqjignaofyupiowxwsug4xp5inekvn24@qriseqkmhke6>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6wtktjmptvddkeo3wibqjignaofyupiowxwsug4xp5inekvn24@qriseqkmhke6>

On Wed, Oct 08, 2025 at 02:41:11PM -0400, Derek Barbosa wrote:
> 
> Of course, we could always go the direction of just dropping the functionality
> of parsing said "old" sched_debug files. Clark said that this may make some
> people upset though :P
> 

I agree that's the "easiest" path, but I think we may want to poll the
community to see if there's someone running an application on a 3.x or
earlier kernel and has a need for stalld. 

We can bump this around a bit and if no one raises their hand, we'll
drop the old format.

Clark

-- 
The United States Coast Guard
Ruining Natural Selection since 1790
