Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C551917F1
	for <linux-rt-users@vger.kernel.org>; Fri, 17 Oct 2025 13:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760707247; cv=none; b=SjHdOPq49RJ8+/orNSbfW89jodfxT5NBW3hJxaqOmLwh0NLeLs4Zycbr4SV1NSJbirljTRZgMTkauQxAKXimC6DHGkR42dF7Wh32JCuET0CtfLBmxTq1HNH6CjbNcwuN7vrZpmNibSB5w3xuAOMcgZWdt8vxIcQClgP9rb0AHfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760707247; c=relaxed/simple;
	bh=qfGQhIkOeWafeho67R6W8yIhsfKCnUr1X9GLminKUbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dfbqikIVVDq/UwB+/NYOUv8RT6SU0ckUtnGzkxEp5tWHoGbLez/mhhH//LMbPnN0cxGNuFUWJPYwXhc4+hJKfshlSjXLTdci1wjPndWlf7Ow+9C+wXDx8RH8eCWyWKdAQp2w9KwgL8J/eymZ7YuXsEQkCyf5HFQkdTAdXRKQxhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QYxiWC4l; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QYxiWC4l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D226DC4CEE7;
	Fri, 17 Oct 2025 13:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760707247;
	bh=qfGQhIkOeWafeho67R6W8yIhsfKCnUr1X9GLminKUbQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QYxiWC4lyw9hn00hQgJ/Ew10lnWB1zz9hEYKLLY3GtuE3Z/matSkluGv/cmOzmJCw
	 mxmbbL2jzpPCSf1dgXF++X73X4iRR4iNpwb/QoXXNbhwM8BM0VmI+wc+XBiVy2i+rH
	 BJ0J/W3WjWOra/diR1yhhXToZLsY4OIrPbD6F6To7ELNwLAb2bUfrm2PwNwUDoNo+c
	 0VI13QXmLLuUegw25jTjbxSTrtBdOq+TBCHOGkJWS7PTAj/Lvv4O5lMwVI1SIiMw+K
	 5TkwfjmtVKJyEINyAHuQR4Se9GGnOJNgqiLrWiRqPM/gjyO1Qai8R3Ei1raVHGYNSV
	 MV9+9VmoZ1Y5A==
Date: Fri, 17 Oct 2025 08:20:45 -0500
From: Clark Williams <clrkwllms@kernel.org>
To: Crystal Wood <crwood@redhat.com>
Cc: Derek Barbosa <debarbos@redhat.com>, linux-rt-users@vger.kernel.org,
	wander@redhat.com
Subject: Re: [PATCH 2/3] Makefile: Add support for legacy kernels
Message-ID: <aPJCrSz9tMdg4bzS@lysander>
References: <20251002205515.1299816-1-debarbos@redhat.com>
 <20251002205515.1299816-3-debarbos@redhat.com>
 <adb796e86ac3cd19b55ee399662b8ad97dc2bba1.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adb796e86ac3cd19b55ee399662b8ad97dc2bba1.camel@redhat.com>

Apologies for the duplicate replies but I forgot that I was replying to
linux-rt-users and good-old-gmail helpfully added some unwanted HTML to
my reply, causing it to bounce. Sigh...

On Tue, Oct 07, 2025 at 01:50:57PM -0500, Crystal Wood wrote:
> 
> Speaking of SOPTS, is this tool intended to be Red Hat specific
> (and require redhat-rpm-config even if no RPM building is intended)?
> 

No, I really don't like that we have it there in the main Makefile. Unfortunately we can't push it to the packaging phase since it affects things generated at compilation time. 

Perhaps we need to have a Makefile variable that identifies a "distro" and triggers inclusion of a Makefile.<distro> that modifies the appropriate flags? I know it's ugly but I'd like to give other folks (suse, cannonical, etc) a way to tweak the build. We could default the variable to "redhat" and have a block that includes Makefile.redhat to modify the CFLAGS appropriately. 

Thoughts?

Clark
-- 
The United States Coast Guard
Ruining Natural Selection since 1790
