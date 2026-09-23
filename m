Received: from mail.nearlyone.de (mail.nearlyone.de [49.12.199.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37405616BC
	for <linux-rt-users@vger.kernel.org>; Wed, 23 Sep 2026 16:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.199.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790182371; cv=none; b=eBVkCep8Gesh5wMK6G+b52fsxm50AqPrFJ0tI2hCLxAZQNSditqimGPsxyr+et+r3UndpvgcGNuwbQwgABHIX6jaUwJ67Zj/20dlas4u//22lbPp/jI/Hsk63IO2FJY+Iulyi4e3Egcc2a3hLwRG8qjyndiAQXWSIOJZnV9pHr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790182371; c=relaxed/simple;
	bh=YUhdpq7dSxnsuyeaf7HN8BwEtcm4vAoTzCDU7TFTnH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YfPVHYa6FXWhfRY1TQVLItnDlVvOdkPQnrptVb6d/MO2TDx3lmpNDYa442YGeiz9YTcbbNLOph458eG8PTWNY2q660wh2AZ6qjTs6zRZuBhYtliGf7PSDzI4YOpfDTzkON3PqZb0h16m0idm5oxyOFa2dv/Ozz45yezTe+W1HJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=monom.org; spf=pass smtp.mailfrom=monom.org; dkim=permerror (0-bit key) header.d=monom.org header.i=@monom.org header.b=pBMAP3bo; dkim=pass (2048-bit key) header.d=monom.org header.i=@monom.org header.b=jD97i4Rp; arc=none smtp.client-ip=49.12.199.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=monom.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=monom.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=monom.org header.i=@monom.org header.b="pBMAP3bo";
	dkim=pass (2048-bit key) header.d=monom.org header.i=@monom.org header.b="jD97i4Rp"
DKIM-Signature: v=1; a=ed25519-sha256; s=v1-ed25519-20260726; d=monom.org; c=relaxed/relaxed; r=y;
	h=Message-ID:Subject:To:From:Date; t=1790182224; bh=cOdkw+rM4G3dkYeYclGQ+KQ
	TnBsoFcnn9ilKDbTak7A=; b=pBMAP3bos1emrPGYsmv5ErB3qcCS/HWF3skW+G1eFc5Qs0JTFN
	XaFMy8v9iozgDz3+Fh8a50ibCpDkn+NKo5Cg==;
DKIM-Signature: v=1; a=rsa-sha256; s=v1-rsa-20260726; d=monom.org; c=relaxed/relaxed; r=y;
	h=Message-ID:Subject:To:From:Date; t=1790182224; bh=cOdkw+rM4G3dkYeYclGQ+KQ
	TnBsoFcnn9ilKDbTak7A=; b=jD97i4RpH0TBdlqQPjaJF2HwNBZh8Tfm5L7EQ8OEWgsB1y8RjE
	yYu2/tGMi9XV1RKl/BButVL+jLGLcXKHADlp5pIGuZwrrp2wgRC8sJj+Ao5V84EO5xFxzjRqMkS
	cBca4u/8ymZuTIS0B7InjttJSzDzup8n/qIQ/wNYD+FjEXR0TU/YMVTjsE/oxch6UN6c2DGxFhB
	UBtAIFi64MSFC1+XDvTZGIz5D0ENZzfKDRcrF8a9ISa9ETn0NjfmPZxnVKnTTyhjb/JJohdg4XU
	VMY1m/O9DSad4UlZiTCptn96mNXDeBH+xEnTl2TOZmu4YqoQGwfz1c/0cUtZ0EjRaBw==;
Date: Wed, 23 Sep 2026 18:50:23 +0200
From: Daniel Wagner <wagi@monom.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-rt-users@vger.kernel.org, John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH rt-tests] rt-utils: Remove access to /sys/kernel/realtime
Message-ID: <4903da8f-c073-482a-b395-253ad2cad4e1@monom.org>
References: <20260923131320.5zhWJFy0@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260923131320.5zhWJFy0@linutronix.de>

On Wed, Sep 23, 2026 at 03:13:20PM +0200, Sebastian Andrzej Siewior wrote:
> The json file reads /sys/kernel/realtime and then writes the attribute
> 'realtime' = 1 if its content was 1. That file is only created with the
> PREEMPT_RT patch applied will not be submitted upstream.
> The information can be deducted from the uname(2) function which is used
> and all fields are written into the json file.
> 
> Set the 'realtime' attribute to 1 if the version field contains
> 'PREEMPT_RT'. This was always the case.

Makes sense to get rid of the dependency on /sys/kernel/realtime. Thanks!

Reviewed-by: Daniel Wagner <wagi@monom.org>

