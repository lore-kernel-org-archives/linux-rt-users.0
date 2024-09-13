Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFAED143C40
	for <linux-rt-users@vger.kernel.org>; Fri, 13 Sep 2024 06:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726210447; cv=none; b=D76N80BtQSmh51JQ9qPPstyCVfOvRytnjYwE/n11UEv3ZnA4yK7W0zXgkVLtMCzPpBySZLhOn4+yBgI224etQSlYX1aJNB2rALKr9Eli7KEz60HLETbjCUkTz4QRDBnmaZlqN2Lo7yfvL2f821ePxRSWtUgHYyn5mInkseULM7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726210447; c=relaxed/simple;
	bh=FuZAA6ShEkpp2yhPDtcVcwuoTNcyySx4bRzJHjMg7rs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GtJXW4ZBp/Pk+uhiywl1fI3gzan2Pr6VaUNjd5laHzWlzmqkQZNtIXwCv60WjsCf7VT42URi+CXDsDXgj3ojow1pkPyEzbIuB10fDRf8QW0FPFJMISBoE21IF7f1tpqJK8pYPDYt0eF5vs/IRL0TIquEf0UbTy4VkAABZ43NmjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=wjc40H5q; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="wjc40H5q"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Content-Type:MIME-Version:Message-ID:Date:References:
	In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=FuZAA6ShEkpp2yhPDtcVcwuoTNcyySx4bRzJHjMg7rs=; b=wjc40H5qQfGA8qmta4zEnk4Prj
	r4SJRU2P6rHArKCU6D6GgmQFKs487L2kJscDgUQzeZeQLGSf7U5GVPMkBe3lM+dq99S62MqAMtX2w
	zLOi00SwQZuMdrBWr4+BtWDHLMyZkeI9GP2naPkXrYXcF8s5tO6JCgjgYB8iKSuakzGUbd8KgWgqX
	q87qnPtrvJUCry+Ej82F5NK8VZ4/oi89YtNUNw7E5lt/rBHUOGeEfW7SH3Gum4WA23BiNTH0pDmZG
	Oq/fq/KXoOc/sqMwo6PBnS5dYZEihN2/xISKMihaoWhARbTHAocLDHWMCp6m6ZU/pTxKgFGG4yucq
	C55OIEKQ==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <esben@geanix.com>)
	id 1sp0Bt-000KUA-G5; Fri, 13 Sep 2024 08:54:01 +0200
Received: from [80.62.117.18] (helo=localhost)
	by sslproxy01.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <esben@geanix.com>)
	id 1sp0Bt-000KCN-2q;
	Fri, 13 Sep 2024 08:54:01 +0200
From: Esben Haabendal <esben@geanix.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: linux-rt-users@vger.kernel.org
Subject: Re: [RFC PATCH v2 2/2] serial: imx: Switch to nbcon console
In-Reply-To: <87edb6gbsn.fsf@jogness.linutronix.de> (John Ogness's message of
	"Mon, 15 Apr 2024 12:34:24 +0206")
References: <cover.1712303358.git.esben@geanix.com>
	<2bc0b5d3f99184d8ddbf860666513f9fa7760af8.1712303358.git.esben@geanix.com>
	<87edb6gbsn.fsf@jogness.linutronix.de>
Date: Fri, 13 Sep 2024 08:54:00 +0200
Message-ID: <87frq459iv.fsf@geanix.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Authenticated-Sender: esben@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27396/Thu Sep 12 10:46:40 2024)

John Ogness <john.ogness@linutronix.de> writes:

> In your imx_uart_console_write_atomic() I see lots of register usage:
>
> ucr1, ucr2, ucr3, usr2, uts
>
> It is critical that _all_ usage of these registers throughout the driver
> is protected, preferably protected by the port lock. Please go through
> and verify that. If imx_uart_console_write_thread() is using even more
> registers, you will need to check those as well.

The _write_thread() uses only the same registers.

> For the 8250 I went through all uses and found several problems [0]. The
> imx driver may have similar issues.

I have now gone through all usage of above mentioned registers in the
driver. I found a single missing lock/unlock, but other than that the
driver seems to be in good shape in this regards.

In the _probe() function, the following registers are accessed
unprotected: ucr1, ucr2, ucr3, uts. But I assume this should be safe, as
the uart port is not registred yet, and interrupt handlers have not been
registered.

I will send out a v3 short, hoping we can get this in a shape where we
can get it merged shortly after the 8250 driver nbcon patches.

/Esben
