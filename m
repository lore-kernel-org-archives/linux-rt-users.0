Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF8F3D6690
	for <linux-rt-users@vger.kernel.org>; Wed, 15 Apr 2026 14:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776264520; cv=none; b=ORoef+akOvRL1J92YeXODDkPfTHq2YotDe1WgI73Vejnfv8qelRg/Uus35dzThDS//yYIs/9fWFHEHt0HtwH+sk6SrHXQhN2mfBYi7dzmiJ2qdhQY7PasOeIstVNLe3A77w64hlnztO2lGveCOLB1TA8VFEP4H03xUtKPEwXX7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776264520; c=relaxed/simple;
	bh=b4paVfii/IK6BLRS/pNouZBujOQxmvwXMFbjPz/7+Co=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iOT1nrAOAwla+fc3qWKMD+94APkcu24ZpI4zqqF/KEMKHOPPt0HttqgUXb/aW09ILRBnjAQBQoBlay9OjIAnITrch3K2zUqwJbO+ajIfHkZPIvjmUuontQjNTvUlLQtNS1vUBZyQiAMKRNrmimGXCVrojN03IUvU9EG4500XAiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k2wCnBma; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k2wCnBma"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8cfc2d1fdbfso517027185a.3
        for <linux-rt-users@vger.kernel.org>; Wed, 15 Apr 2026 07:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776264517; x=1776869317; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b4paVfii/IK6BLRS/pNouZBujOQxmvwXMFbjPz/7+Co=;
        b=k2wCnBmayo68OkQHT0QE/kfAd565D0u9JCpjqUrbgQuEEVMXntMN+VBk3qzwK1D+mg
         g9D9qtpzEp5PTgidA0HHXdS79kpwIbKjHd1Cz+TImfuWjUo5PGASAHSonu+UCkPwCk1l
         2oD4mU6+qrjq51YlLF4zcHLwokUlm3xUvqRdYbnUSqCmwwpb51LDpXT0VGsDQWfZEx5U
         JRmBLST84eCDp5TQxqDebwVH5lj5TvBftT4wcj9tDWC/B4yd+w1mhYq1sjLkDjs3+yR7
         MRBahtwwjRShHDUESy1JrEGpegbR29MbcaHGmZaUo9h4sDLv069bUFLAPfvUQFaR74aO
         eHvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776264517; x=1776869317;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b4paVfii/IK6BLRS/pNouZBujOQxmvwXMFbjPz/7+Co=;
        b=miEDfZTndhcaKttEtkFT9ViuQWdbWn8fVaaRx/maQMigOyrp+UEzOzJp0xlEzDugTc
         tEingw9CmJfv8vJSHEzpkF9xhQHktVevNWLHDp883WRE/UlVA6w1bY2wyoWWqqBA7zz9
         uKGWtotRz7eNlA90siSNu+ggQMsgT6SkZC7ZUOKR38w1BdJXWBUWbx75KzGIf2syY7FO
         aOXFBE2JOJdgmrEZjrw5KHGGisZ20VB3YXjv5MBCSU2QJpeJVsuQ2YLiHUZsS7A4c9Sm
         llJnMZEAEHf4uR2R5vwyLeKT5OlhCxNZesG8UhIqrLjThF7rVU6Imr9zdSIPvbHe6kgD
         ZQ2g==
X-Gm-Message-State: AOJu0YwpQ5cmJlmbfX9GR4uvCsYZm4e5s0hSeomfATqS9+wR826ankHH
	TjO6ZcvDcpoox729WF/Vlledt8xSmkDRTKatqY8DeqIYdWgnE7HXEYm+m05ZBQ==
X-Gm-Gg: AeBDievZ7G/WTZ0WotNbRi2sGHrx4BLyNekUaG6dydmqeQHKoSq0eWvE5PVoT0R09Mn
	gyKRVjsS2YAZNaU1HEg4kVKvlceOkM2szx+3nY/+jgXaj1uu32Do+ktUGyFrX+F7fR27hDcD2AN
	xytjPLzhNduhZ/SP0N7+w/gj4abVup7FJIAGkf6bOTT73nszAWpqNHFuXIx4dT8IAVerX+rw6nZ
	HnOQy9/nIvqFUBpY6ghZpVYTxKuDe7KmscQxtbuIbF9nUkg9GNkYQGSgz1tg8+RhuwdrKvEVuw8
	ovN3fMPYEAfsbosBkdgGZtKq//wkjX5BA9rAlHvLsgCcM3mQ/Lh1pVeKnBcin8BeYjVBd/VoPoo
	cMTs3UxLxSmMLOwJAxU0pzMiPOpKDwXuofGO+DJ9wFuQiZWpEZpdObn/Ll+CekB9CVZw0UFjVUF
	nqECqYlV40iN8BXtCfGERNx9h3fBPKtOFb8qOLJDycx61u8r1kJXnGTrCDnnaNIgzbNkJeDfpvY
	t17jADF0YP0wT/1IT8=
X-Received: by 2002:a05:6214:4b0c:b0:8ac:a0b0:64d5 with SMTP id 6a1803df08f44-8aca0b069a6mr253962576d6.37.1776264516680;
        Wed, 15 Apr 2026 07:48:36 -0700 (PDT)
Received: from Cumhall.redhat.com ([216.209.112.32])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ae6c954368sm14063386d6.11.2026.04.15.07.48.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 07:48:36 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: linux-rt-users@vger.kernel.org
Subject: Re: [PATCH 6/6] cyclictest: Add support for auxiliary clocks
Date: Wed, 15 Apr 2026 10:48:21 -0400
Message-ID: <20260415144821.110074-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260407-auxclocks-v1-6-1ef80d14eb0a@linutronix.de>
References: 
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 07 Apr 2026 at 08:48:46AM +0200, Thomas Weißschuh (Schneider Electric) wrote:
> cyclictest: Add support for auxiliary clocks

Applied, thanks!

Signed-off-by: John Kacur <jkacur@redhat.com>
