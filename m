Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0363D4112
	for <linux-rt-users@vger.kernel.org>; Tue, 28 Jul 2026 21:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785273426; cv=none; b=ASZ/0jrJZ3PqI9Hg0YaDuHWUOZd8iZVxDIcbcxfmeZs3fzrSoDYPqIWTWum/1jpElvQI10DqsFLCfTPE1uqAwrjXKiOdt1AlFiwvjI/BHPW9hPhh+fwnuetPB2oKyJB7ctwU35zpfHSBdMsKLLF00ncW5IG9Vz9N+VopGSDWx58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785273426; c=relaxed/simple;
	bh=rdnurc0ji8EAul6ooHeNTkkDG/mulCV7doG/1kCK3wA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FR4vS5SAyOc+umfbWaqIFHV9gJBlXmDzdyYCq6+cjRRuj4T0U688Gh1Q1T5oYjUBGzONfeLsVXjU1n3Mezx4dr3kbCWrjnMtz8VJG54KNF7pc9qpcvu1f0kNFIRBQMxpa9bszgEC8LESt0oI/gGhbZlkXSoIPwqI5Q2xk9rpIzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JHPmSrbG; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JHPmSrbG"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-5218927884fso2908731cf.3
        for <linux-rt-users@vger.kernel.org>; Tue, 28 Jul 2026 14:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785273424; x=1785878224; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=rdnurc0ji8EAul6ooHeNTkkDG/mulCV7doG/1kCK3wA=;
        b=JHPmSrbGmP/xM8yFJe+NVECTzQFJiPU8nVPhtyeMHkeI+22x/CnzJnEMhiDbyCFH+v
         mASOXjnRZqxs/eId7vSqJrGhEk5VBzNV7T5KobObueY+o72fUYJJHE2g2CzzyHOdHsAC
         T/E+UxV+td0kSN4Z1xJYtc2D1mo7gfRdS8PXwOgnBB6QpJqdOxZJesrj/js0GTCd+EAT
         M3+pT+dvoENb9Hh/R27+JGxvRGWxOVUtHUSBfzCz1exFLQO89wn7LL0VayYxG0cpmU8X
         qWNNgc4/oiOpnO6Ncdv6dY2Zu26giWOhsyY1J9mwT5XZn+2LL9luaji5aU6nTIaCKysx
         ibYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785273424; x=1785878224;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rdnurc0ji8EAul6ooHeNTkkDG/mulCV7doG/1kCK3wA=;
        b=QEprdtn/YSSEfzaJvk48/N9SRWQabke7G/gesPH2nYk6KqfEKzK2yAZconN84MKQVU
         9IK6IWhOlnr+YvazkVkubniJTxhXlYFyxk+IKUH23RBzrvM1A7grcuuCfsGLtyOxvYRM
         xNXRZUjos99gsk1NOlt79eFLcnwED7UVHPzF2L3IXmfoLK3WuqI+8q09GZfhxv1/f5y8
         U7JcKIPDe5Rghc/ClWCVfnu5QQ34GgOvP1fj6Mgvvt4W1bEXCCPV8rkOQ0Z0Biq+Mvb6
         F7ibyb1xTlG623EDSaZ7OK63nseXaKLlcc21vlACKl3HfPsr4SklLtoUaI/yLMKOmLG+
         8F1w==
X-Gm-Message-State: AOJu0YxHlCTPZ4DDkPaSOOzXvzrk4IcbBh0zScjc0khk7EBtdwmyVT3C
	SqgdKYC9jGXlzOejAaLKILY31u+ZbOtkOvixLTc8K7K51nr8jB5iMgrt
X-Gm-Gg: AR+sD12hNHgVr9IDjwGVDxCnxF+xg79garbBJjwizu3S8Ih/aXAXuDDdG3cJvtX7AyN
	V1WKF/YoilpRLtpgQGi17/7xoBADqc0tyKQ0jmwYDZolaJRxNMgA7A/srqUSJ+affA5UtYEPy8v
	CrsT9BQOEvlrNhMVWxtUV97xTnzKFG9jiMJF5Wnm+V1zQdDirVpGr5fCMjqW0Gv9uocz4JNT9gl
	pabaRzGB63+YrOYdSjEc1fSLLzg0VcyTcMuHy/rH6oJjPcu0x8xJQHR5bYaE0NW92RzC5bp2qTJ
	bomaVNpvBwOLn+yNuROKTNQyqGKr2gmGEuXtUVQl7cTM0I4QzOOSfuOPEowH1NtrheItG7iKg8J
	46yhtMfPbqVvUsCdAPwabmLaM0BrxFcn4fpVml4768jy7tyeoO52m0jNBT4DQrz04GIc0SNqB/o
	En20DUXXtlN+JpmV5lRwCoa3MRC52fqbbHbAUm69vI1HUGg4l53WTB49xvqdm7nwP/QA614qfOx
	yCo4+mwyzESPQwHmjvMz+thxLJFnGl0R0j684GmOMHgm1FXWeqxKCw=
X-Received: by 2002:a05:622a:412:b0:51c:7b12:5fcd with SMTP id d75a77b69052e-529d7164fc9mr38244551cf.73.1785273424226;
        Tue, 28 Jul 2026 14:17:04 -0700 (PDT)
Received: from Cumhall.redhat.com ([174.95.68.136])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-529e2b1a203sm6648831cf.1.2026.07.28.14.17.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 14:17:03 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: Costa Shulyupin <costa.shul@redhat.com>
Cc: linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v1] rt-tests: Exit with failure when breaktrace threshold is exceeded
Date: Tue, 28 Jul 2026 17:16:48 -0400
Message-ID: <20260728211648.258382-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260727191545.3023834-1-costa.shul@redhat.com>
References: 
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, 27 Jul 2026 22:15:45 +0300, Costa Shulyupin wrote:
> rt-tests: Exit with failure when breaktrace threshold is exceeded

Follow the conventions in linux/Documentation/process/coding-assistants.rst of the Linux kernel and don't forget your own sob.

John Kacxur
