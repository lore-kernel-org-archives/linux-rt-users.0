Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A536C33C1BD
	for <linux-rt-users@vger.kernel.org>; Mon, 26 Jan 2026 15:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769441004; cv=none; b=KinjpdJnq8e0BeQAp7VnJUyieR4JJrXARqGRv9ipBwNx1IKKa4BnDaddeBrAORSRYZPNnaz9jyD+nJlsgcv91hEjqfOFFPvFZSbWS8Rkgk5kXQ7BoQbFnnr/WYhpJSXMMM3+bXAO5DthysT7JJjdhiFSquT3ObUNenL7zdGgNew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769441004; c=relaxed/simple;
	bh=5Af/00BpOaY/pozw6xDwHa8+/EjKFb5E2I638zF/MiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vAlCvCQPRTUBbMe+O8CbJPsqC5T/05M2QM/Agq4vVb1UXG91FIi8pBXMleqEAOGrG7P5N3uAAznS3m9Cn6maWm29Rxla85tDRDeZYWab4w1LbLic6m6/xHXd7PwbbKJSUKmzAyFqzWCD4vc722+MmQQQ/Y5N/ZanJN6aLDze990=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EOIgiV9Q; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EOIgiV9Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769441001;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:in-reply-to:in-reply-to:  references:references;
	bh=3smk0yDxxrlllekDeB6O/jlYl5XtzmHNOMKXC5krM5o=;
	b=EOIgiV9QJc+f7Sw7u/WBnZquLFf4zVjKXbHPZ1ZlYXlncmLwv8Uflq+ZnAWoqfcshY9uUr
	bPzMIP/gDpv4yJm2f9bVtPiia/3IBD81+w0hE2i1I8GPXutYERoAvyRjKBM+VipBlPcwso
	iZwjYfo4cLDxLm44RowHTpHtrON9pVs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-435-GWfdU5xgMDGGRH8eytyYdg-1; Mon,
 26 Jan 2026 10:23:18 -0500
X-MC-Unique: GWfdU5xgMDGGRH8eytyYdg-1
X-Mimecast-MFC-AGG-ID: GWfdU5xgMDGGRH8eytyYdg_1769440998
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0B1981955D4A
	for <linux-rt-users@vger.kernel.org>; Mon, 26 Jan 2026 15:23:16 +0000 (UTC)
Received: from localhost (unknown [10.22.81.105])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8435A1801AC9;
	Mon, 26 Jan 2026 15:23:15 +0000 (UTC)
Date: Mon, 26 Jan 2026 10:23:14 -0500
From: Derek Barbosa <debarbos@redhat.com>
To: Wander Lairson Costa <wander@redhat.com>
Cc: williams@redhat.com, linux-rt-users@vger.kernel.org, jkacur@redhat.com, 
	juri.lelli@redhat.com
Subject: Re: [PATCH stalld] Remove developer-specific configuration files
Message-ID: <6u67jhrwjfkhu3fv2vfr2ejwozruhafuo3xjdkasxiotum5trn@e3uhbogw5qt2>
Reply-To: debarbos@redhat.com
References: <20260126130557.45950-2-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260126130557.45950-2-wander@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Mon, Jan 26, 2026 at 10:05:30AM -0300, Wander Lairson Costa wrote:
> These files represent individual developer tooling configurations and
> should not be tracked in version control. Their presence leads to
> unnecessary diffs and conflicts as setups vary between contributors.
> 
> This change removes the .claude directory contents, including project
> instructions, agent definitions, session state, and behavior rules.
> 
> Signed-off-by: Wander Lairson Costa <wander@redhat.com>
> ---
>  .claude/CLAUDE.md                        |  585 -----------

Hi Wander,

I agree with the sentiment of the patch -- but maybe we would like to keep some
version of a claude.md/gemini.md file? It would certainly help with anyone
trying to approach this project with some sort of agent-assisted coding tool
(rather than having the agent infer the architecture of the project, etc).

Otherwise, LGTM!

-- 
Derek <debarbos@redhat.com>

