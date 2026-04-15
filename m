Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A38B3D3CE2
	for <linux-rt-users@vger.kernel.org>; Wed, 15 Apr 2026 14:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776264440; cv=none; b=mvKrjDdEUKvaIc4oBCGTWsr6F9Ad6E+uOziakJE+dTBNZVSEng+YbewWxSkM30j/yW9gLE1jAkj9qhn3zD8Y1WBpnttOc1yQgB7D5fy3swezpW7u1ZGkITyi9D7RMGYkfZ5fuaZmcCEIEeMXWyGfa41PbF/bW3MOFpBPdSo2WUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776264440; c=relaxed/simple;
	bh=s8hkUuAImknCpEsupw+a9gvfhjjjtoKGwI9f1r4y0Bw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pHhq6w67/gw/YkqMWebPXL8NYpa8gFK7jyhFGJd5/hEs9X7llTj1ByFEvLrrlLewbdS2O5S21JldJujQnZi3DRJCuphraDe4PP68uIO4I8ZmkH/RL/0q+Ngcje9bbDcPe+hPA515Cz9Xe8yhEisrQI80iRmxWRIybinqCbYvMps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gxg1wPT8; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gxg1wPT8"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8d933da14f0so727769785a.2
        for <linux-rt-users@vger.kernel.org>; Wed, 15 Apr 2026 07:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776264437; x=1776869237; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s8hkUuAImknCpEsupw+a9gvfhjjjtoKGwI9f1r4y0Bw=;
        b=gxg1wPT8ez86a+uvdGp+wO7iIQYXqK2I+0rmgKLYMswUZIxbf7vgHsxJQG2UHwhVuw
         v2QwxSZWu3wroHlxfisRmmKnoF/ooht7pA/hnA728u4JBf32tJJtX1nOezu3xLkA5Sfx
         srUc2uQxzfZ+x4ENId/RbYAeh70DiOBtAh4GVXIKVojTtUT4JzstFjpktIaCxiyoOUhu
         VXtydpr97OTyFp4NxP017iVeR7GySPuc2RDCRVyhGhOKt12kxT8iPEncn6Bz7x9jZ/qO
         5cVIhEGv1KtXDZ+YVYJHdmVRgDqkUbUw2qTWS2P3edTujcHMo2Fu9fYsMqedrQ6z7bhz
         mQCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776264437; x=1776869237;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s8hkUuAImknCpEsupw+a9gvfhjjjtoKGwI9f1r4y0Bw=;
        b=GfgVjKu35IavfC4Rk2r9BpM7NxnxtU+QhEqPmalqNiSgoe1NxLYypackhBvnaQZ97X
         3uNyiLEVSsonWERlzUj0PE6OjI+mcp4yXLethUuNiMI8P2s9JcnQcTcEfk4qpIVI3oDp
         sMiIxE1nufSUi1tKuAeeT4nFMo2b9UAR4eQjDK++ehnaYj+Buj7ygxrvUCXeM1Ko1x4B
         gavs4znzaEwTgH6cyS2QhfePMYyYKyjD/s4fumL6ekRf9JmOE0YEWYF1lzUb62XwIR7K
         4D8m5K2x1fpk+IdpV1h4JgRSQV7LxgvsezuMFiXPgrvm8QpfR71YsV/fSr35ed+rfxna
         aS/A==
X-Gm-Message-State: AOJu0YxJpDy5vQoTzyndXqJbDt0xjByp+dep7wux/Zl+hJhw736ULWdq
	R4Ujm63KC2+kr14zPLLsuAxKV7NOAvVCLUkzGOflZ75/hoOO2hpWl2SzC4jtWw==
X-Gm-Gg: AeBDievq7FCd43eAtTmTDiKHWlomfeb0Sh6kzKXR1GvyZf+7nuLq1jideAMrDAumg46
	LQ2M0Zy54ANu93VPu8goQzkEAbaJnJAplqiQW2zqFkfRysSk70ASlr08UtGB9lxOd9M1sI75B/b
	+jmsK5LdHXncdIVzJ6NnxqZSKaMOma5j34W3pb7yUyzLauP+YFp2r9NjeLfPF7ae6ErfnuX+tu3
	99n4pfsfMR9eo8rbcQP94j3J83ZTm/I1MQuPBSIxxaOgNi+lx5NCQZhuiMfOoLxELiJEGZIvY4D
	QsOE6i4og9ygeYtk2ZR6IkUlNppPU25rzbd6FzelKgC8YDdx4VoFKdbwwjg528UDxWMtMZgNorv
	U61uqlqvDmbWJzMeUqBbkgz1+Q9ytje/qpMxWMUk5+iCAX+4hbOSP9Xs4qmHs9+R6eWGWgy3nZP
	ObtOTU3jTqfDm3QRZVz7uPBMDJRVymUS9lPUZ3plRtmpIwbvFNifVXPCE8mALGXNyQPVfzpX4iT
	4GMKCFvJC8BAJ4sEPcd9r1mL0BAww==
X-Received: by 2002:a05:620a:450e:b0:8d4:aa50:686b with SMTP id af79cd13be357-8ddcf1b865dmr3006251685a.31.1776264437348;
        Wed, 15 Apr 2026 07:47:17 -0700 (PDT)
Received: from Cumhall.redhat.com ([216.209.112.32])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8e4eed6ed8asm135055085a.1.2026.04.15.07.47.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 07:47:16 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: linux-rt-users@vger.kernel.org
Subject: Re: [PATCH 1/6] cyclictest: Centralize clock option parsing
Date: Wed, 15 Apr 2026 10:46:59 -0400
Message-ID: <20260415144659.108818-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260407-auxclocks-v1-1-1ef80d14eb0a@linutronix.de>
References: 
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 07 Apr 2026 at 08:48:41AM +0200, Thomas Weißschuh (Schneider Electric) wrote:
> cyclictest: Centralize clock option parsing

Applied, thanks!

Signed-off-by: John Kacur <jkacur@redhat.com>
