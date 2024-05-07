Received: from mail.nearlyone.de (mail.nearlyone.de [49.12.199.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF68215250D;
	Tue,  7 May 2024 11:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.199.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715080308; cv=none; b=S+tCr7HwK4ukEYBpURhzkXdTi56bKq4ldF2AsVpMVR5cwcFFjNhovc9slPnHQ3OK50+XZstlLqPfBVFsZIEsQXySuJjLQtc9/7GF3aIP9KtWpNl7h4m6u6iMHyA9tW2pdnaJHVuRHAFg8ymlW9A2Xl9XfgS53A/JLcXsNENoBMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715080308; c=relaxed/simple;
	bh=ugirj27XhqixAq69VU9txIVOtc8CmdlxXWxSRutQCds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=krbMElN2NnfUmcFTmP9YCNr7h0GcWZH2VPSIjpQ3nppdnRir9HMHcD4tXg+K97JwWBLkc22KYWrrEwMbG1Q+dI7Pp4/qP/QrrNkU+gYkr75u/FzEmkHpdwpXGnjA5rKwD+O2wqLHql35czuCFnPkrJoQQ2IR5Qs3PHHu/bh5nrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=monom.org; spf=pass smtp.mailfrom=monom.org; dkim=pass (2048-bit key) header.d=monom.org header.i=@monom.org header.b=lhjEK3p5; arc=none smtp.client-ip=49.12.199.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=monom.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=monom.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=monom.org header.i=@monom.org header.b="lhjEK3p5"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9E847DB3F7;
	Tue,  7 May 2024 13:11:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1715080297; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=lhggNZcChQN1+cSOoBexSrlJQQ7dgudKQ/bV9WGXnRI=;
	b=lhjEK3p5hYOrmqFxzDCYlQQffO8sEE+WO8L+WpKZpWx9Cai9ulv0qsq9H2ZNOqPxRZCLDi
	Y6Pdw3Gazkcwsvv5pp4qB+sinzjEJnknjTHKsJcPiIKAe+orXLRk0ZLQzCVdqlRygF8d6V
	4v4h7NXO9P7cCG0NLQ2VTrV8e8yc3EvHQW2jDALWuTpGIzF3bMI+GmndryiRlkjxU0s0WT
	TedNrkpYt5mVagcdhFcTnLw7aBQoWepx/0WTy8YkNRWsoMelZaq+qIkrPAHkFnx3nmt15W
	RzuyScHpgJCapEG1pb6fHx3JEJsD8H4pJpiJpO8CRMl4UasMYvddtCZXGJu5qA==
Date: Tue, 7 May 2024 13:11:31 +0200
From: Daniel Wagner <wagi@monom.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: stable-rt@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, 
	Thomas Gleixner <tglx@linutronix.de>, linux-rt-users@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>, Tom Zanussi <tom.zanussi@linux.intel.com>, 
	Clark Williams <williams@redhat.com>
Subject: Re: [PATCH RT 0/1] Linux v4.19.312-rt134-rc2
Message-ID: <6irersxerqltgzv63uis2rint4ycugtr7uve7j4bbvaccogxf6@qvfg6plzrvsx>
References: <20240506104602.16972-1-wagi@monom.org>
 <5c3ff133-6953-448b-a1e1-6bacbc210e4d@monom.org>
 <20240507095407.jAjEuCJ8@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240507095407.jAjEuCJ8@linutronix.de>
X-Last-TLS-Session-Version: TLSv1.3

Hi Sebastian,

On Tue, May 07, 2024 at 11:54:07AM GMT, Sebastian Andrzej Siewior wrote:
> I compared mine outcome vs v4.19-rt-next and the diff at the bottom came
> out:
> 
> - timer_delete_sync() used to have "#if 0" block around
>   lockdep_assert_preemption_enabled() because the function is not part
>   of v4.19. You ended up with might_sleep() which is a minor change.
>   Your queue as of a previous release had the if0 block (in
>   __del_timer_sync()).
>   I would say this is minor but looks like a miss-merge. Therefore I
>   would say it should go back for consistency vs previous release and
>   not change it due to conflicts.

Makes sense.

> - The timer_delete_sync() is structured differently with
>   __del_timer_sync(). That function invokes timer_sync_wait_running()
>   which drops two locks which are not acquired. That is wrong. It should
>   have been del_timer_wait_running().

Understood. I was a bit strungling here. Glad you caught this error.

> I suggest you apply the diff below to align it with later versions. It
> also gets rid of the basep argument in __try_to_del_timer_sync() which
> is not really used.

Will do.

> As an alternative I can send you my rebased queue if this makes it
> easier for you.

Yes please, this makes it easy to sync the rebase branch.

Thanks a lot!

Cheers,
Daniel
