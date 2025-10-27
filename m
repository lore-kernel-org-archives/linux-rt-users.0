Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E04331328D
	for <linux-rt-users@vger.kernel.org>; Mon, 27 Oct 2025 16:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761582532; cv=none; b=ZE1jx3Zpcs9JJk8ADxX/saATBPQn4SBE/qdnrhCZeLcZ2gY3isXYlHhU92bq25HYBTSwwedcBYQOlVr7nJsTZIk07c0adsIM6B/9KOjaX3MByoZrPf5cMat3zsCHouNBJkBLDrhg56O9+uoDwyAmAivH8E1tRJ0p/0YeqWSaSh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761582532; c=relaxed/simple;
	bh=HLe09nA63KvBNcMVKkBQBz6/YHFJjLT9+YLAhGw1hiU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Smvz2iXuGNruyT9hvOfPd4wm/eOzYSMyDYI33OJxvjA5Y2sOo00TLgUrWEaVYr50mQSDdiox1kDJbzKQwavYghbOXxHoU4C6VfS4wMHTSe8WO10I1xH6LPvr3i5cSh7op2VRHJcFwtlF16B8g4OR7kiJ2day2o1Pr8y+XkKFb4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E74E9C4CEF1;
	Mon, 27 Oct 2025 16:28:49 +0000 (UTC)
Date: Mon, 27 Oct 2025 11:28:48 -0500
From: Clark Williams <williams@redhat.com>
To: Tomas Glozar <tglozar@redhat.com>
Cc: Wander Lairson Costa <wander@redhat.com>,
	linux-rt-users@vger.kernel.org, Derek Barbosa <debarbos@redhat.com>,
	John Kacur <jkacur@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Chunsheng Luo <luochunsheng@ustc.edu>
Subject: Re: [PATCH] Makefile: Make BPF compilation verbose
Message-ID: <aP-dwB-ziszcenTp@lysander>
References: <20251024172115.73224-1-wander@redhat.com>
 <CAP4=nvTHb566uAjuVm_gvBO3t9r0=o2MAKR7dfh6ZWRp0dvDmw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP4=nvTHb566uAjuVm_gvBO3t9r0=o2MAKR7dfh6ZWRp0dvDmw@mail.gmail.com>

On Mon, Oct 27, 2025 at 08:32:25AM +0100, Tomas Glozar wrote:
> pá 24. 10. 2025 v 19:22 odesílatel Wander Lairson Costa
> <wander@redhat.com> napsal:
> >
> > Remove the '@' prefix from the CLANG and LLVM_STRIP commands in the
> > Makefile. This makes the build system print the commands to the console
> > during the BPF compilation process. This increased verbosity is useful
> > for debugging build issues.
> >
> 
> This makes sense, since the BPF program compilation can fail, in that
> case, it is not clear where the error is coming from:
> 
I'm good with this change.

I would ask in the future if we could add 'stalld' to the subject line
text for easy filtering.

Clark

-- 
The United States Coast Guard
Ruining Natural Selection since 1790
