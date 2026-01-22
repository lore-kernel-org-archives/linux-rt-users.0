Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A744D3B8BC2;
	Thu, 22 Jan 2026 11:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769081336; cv=none; b=sKMLELF+WB3ZDgHmmLNPVWJdYNlB5tj0dQE43TIJE0KXCBX0aqOq5CVx2eIojtmHbyGNkWH1NAERk7RKjToE6BFPkC9Yfn6mez1jH6M+7ULdWHqG3oQNYgURAmTKcPhsRWb4WFzsNlkipC8GNrmKN3t7uVSfF0IbpyEdgxZRi4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769081336; c=relaxed/simple;
	bh=x6/akTtN/KWT1JNOcFwCD0vPfNB8Y+8TMzIMTYiPVCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qeks5VKFjMoeLQrfaojHBmvlDwHnc9dv4s15Mekd0Ww28lJPvhFITYPHGcH5ATNdBPJzBIyL9sK3vRb6PQ5JyKb5y1cL3y5/0AZodzAUQTP+N6EeMMl1fGdhNMdyNjB6K7dkUqAKp28n26zdcYi753vtGwJAKUQdbQYtgXLEEyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=CfG0J6AA; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="CfG0J6AA"
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 07A18327EA2; Thu, 22 Jan 2026 12:19:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1769080758;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xbCDoNSwctK7nZcX4ULbVfcxqNF6jqJjOPd4kHlvUx4=;
	b=CfG0J6AAnKwvQcMv8MQRL54ivGjqRXfh7CO1pRfxZSlfRH8MUw8QC1Lp9XppT+hvE3E5NH
	D5aGrZd7sLMqKT3b0MHyuQo5gcqC4rtOSTpjTzr7HHbB0JTJnVFiHI5v+ryBF15LVCfOrh
	en5IYGFyxaUA7QZyhTDNoHmygIMQmGc=
Date: Thu, 22 Jan 2026 12:19:17 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Clark Williams <williams@redhat.com>, pavel@nabladev.com
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>, John Kacur <jkacur@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Daniel Wagner <daniel.wagner@suse.com>,
	Tom Zanussi <tom.zanussi@linux.intel.com>,
	Pavel Machek <pavel@denx.de>,
	Joseph Salisbury <joseph.salisbury@oracle.com>,
	"Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
	Stable RT List <stable-rt@vger.kernel.org>
Subject: Re: [ANNOUNCE] 6.1.157-rt57
Message-ID: <aXIHtRPEGgXGcYWw@ucw.cz>
References: <176132099496.2233461.13982532598284511514@demetrius>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <176132099496.2233461.13982532598284511514@demetrius>

Hi!

I changed email address, from pavel@denx.de to pavel@nabladev.com
. Could I ask you to update the To: list so I get new announcements?

Also, is there new 6.1-rt release on the horizon?

Last I see is, and we'd need newer for planned -cip-rt release.

commit 7f90be9bd646f3b3ba239d08fdfe6d90744cae07 (tag: v6.1.158-rt58, rt/v6.1-rt)
Author: Clark Williams <clrkwllms@kernel.org>
Date:   Mon Nov 10 17:04:16 2025 -0600

    Linux 6.1.158-rt58

Thanks and best regards,
								Pavel
