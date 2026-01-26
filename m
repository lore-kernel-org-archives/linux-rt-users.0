Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5CC33F8BC
	for <linux-rt-users@vger.kernel.org>; Mon, 26 Jan 2026 16:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769443207; cv=none; b=YV4TqrwPrMBAdpGQ0X93cUaD6FA3RS90IwrbF55mguPd5Pvjhvtw/zYvGmlqMEoHVA+/ev85sSpLDDIdfZeNO3igf8MJdbZDm+lQ8xLahNElJ6XgFRtokPOfQvSaX8qSzoc2dulRPqrZ/ESp22dwL9Wgtser2bbnTQHAKXdWa30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769443207; c=relaxed/simple;
	bh=Ss7lhyMS3lzQlFpU0l+dxGjXxG5qc5ZaWgdxSLxcFF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rj0vlJgcACOPYkopIX9PoJdudquzvjvgpFTb3rw+uSSPcWipJX/OfAvqYk6wn1QNqnLNsb4C2OqFn0HcC24Xj7vYtErPml944igVePCM76XYxHeUjf2TpumyHxk+mOhwaV2wsSZgr/GSB7+uOhVg9jDYas56+QSM3RHmzKBmqHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RoAIUuaj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RoAIUuaj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769443204;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:in-reply-to:in-reply-to:  references:references;
	bh=YxmvxBltmeu/K+7skw3pGWiy+NobuHWjHoln/sNh5Gw=;
	b=RoAIUuajD8oJ49EiP684SJrRAAiZA5BFsx04JpjdNFbJ7OU35ZtWoQkwIB8AfdguLjtKOs
	NsYUU7+TFAJbQmIa2iHADKJu0HSNFW6UR6FgL+6oD4qEd0efRC6GfGAlvNttMCGTPo7G6S
	cZ03v5+4tn0Y+2wuHLwKoxmjBzXGUvE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-692-4nZbt1QyO6qUGz_N4ruNFw-1; Mon,
 26 Jan 2026 11:00:00 -0500
X-MC-Unique: 4nZbt1QyO6qUGz_N4ruNFw-1
X-Mimecast-MFC-AGG-ID: 4nZbt1QyO6qUGz_N4ruNFw_1769443199
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5F60B19775A9
	for <linux-rt-users@vger.kernel.org>; Mon, 26 Jan 2026 15:59:59 +0000 (UTC)
Received: from localhost (unknown [10.22.81.105])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BBC4C180049F;
	Mon, 26 Jan 2026 15:59:58 +0000 (UTC)
Date: Mon, 26 Jan 2026 10:59:57 -0500
From: Derek Barbosa <debarbos@redhat.com>
To: Wander Lairson Costa <wander@redhat.com>
Cc: williams@redhat.com, linux-rt-users@vger.kernel.org, jkacur@redhat.com, 
	juri.lelli@redhat.com
Subject: Re: [PATCH stalld] Remove developer-specific configuration files
Message-ID: <ot7ya4o2xzwyqynakh3z53ietdyhnoqqo3377ahf5egdsn6yvc@z4yb45rbucw2>
Reply-To: debarbos@redhat.com
References: <20260126130557.45950-2-wander@redhat.com>
 <6u67jhrwjfkhu3fv2vfr2ejwozruhafuo3xjdkasxiotum5trn@e3uhbogw5qt2>
 <CAAq0SUm03h=D39PLGzKG+bgPWBageM2VtR-RrSj8YHTTua+BTw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAq0SUm03h=D39PLGzKG+bgPWBageM2VtR-RrSj8YHTTua+BTw@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Mon, Jan 26, 2026 at 12:54:23PM -0300, Wander Lairson Costa wrote:

> Both Claude and Gemini provide the /init command to generate the
> initialization files. I,
> for example, always use Serena [1] and PAL [2] MCPs to improve the
> file after I run /init.
> This would cause changes in the CLAUDE.md file. I am unsure if any IA
> related configuration
> file should stay in the repo.

IIRC, CLAUDE.md is in the .gitignore. Let's extend this to include .claude

Would a happy middle ground be:

git update-index --assume-unchanged FILE_NAME
or
git rm --cached <file-path>

on the upstream remote to prevent git from tracking any changes to the
CLAUDE.md?

At the end of the day, it doesn't matter much to me, personally. Generating
these configurations is pretty trivial on a smaller repository like stalld.

-- 
Derek <debarbos@redhat.com>

