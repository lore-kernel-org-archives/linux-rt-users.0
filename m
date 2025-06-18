Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7852C3085BA
	for <linux-rt-users@vger.kernel.org>; Wed, 18 Jun 2025 20:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750277867; cv=none; b=Tms4lsAt6FVMTbBuZ6NqcUClBCz8m1/qimOdWbiH1AKsgpYZifAeqjk4o30Xpnd3SVJkaXgX+5hc0OPu2GPUeoYiv7PGVFdkxk6AaxxKR9VlQDYO3IbDs2M5V7stjlyLCeiemeeH0ZMURMWfJQYAcLF6B4oqT1rqwdzln/Hmw6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750277867; c=relaxed/simple;
	bh=4Jlpz98h2N0cxm1bOOrs9y9KBWPX9IfTtCFwl7JEaDU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Tz4XrIkO7N7sq+v9iF0o+HaDs6GmJv4AwAseIfrdODI5hP4uwskahQ3z0xNEP07ldNYY5JDpNsCyqecdlt5qKXAyezKUl0Vwj5a5iEIykJb7j+ZEl/duCVPu75blI3HW4O4IMeZwLXZHcYa43rxylYgko5xa7QcsDP+bsxL+gZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NeFyul7W; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NeFyul7W"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-234d3261631so884335ad.1
        for <linux-rt-users@vger.kernel.org>; Wed, 18 Jun 2025 13:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750277866; x=1750882666; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Gm7ibFVPgrvk8uy+gqas39LoooBa17lL54UA1n61DTg=;
        b=NeFyul7WEeFtNjahlS4VfRv8XzN0uZ0Scj5R0nHgP5pY1Ohe6zsU3TIjEf27g860kV
         MtYAC1YF6h5vSWlSax4yBf/0NC+pXojun4p7rsLNn2ypzvBimenaVaPDn0KvmPp5qiFX
         eUtc3VMKUG1yMXyAke+yLluhphGzMOvmQqVUDawU75FXPHx1thJs/XxxUIlDUvq7nP9P
         6n/TfLE5PgkaWXu/wtmpR0tu80EFjQbtVmKnUcZ2D6mGaId8+fxvyLMT3HHbYmsLXO9C
         cP3oSGXskKJJ4cTpQ8/aAm4Ghgjv1koj+MASfJcRDUL/Eb/8WIzaCXGLjXZnZ8FadD6H
         iO/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750277866; x=1750882666;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gm7ibFVPgrvk8uy+gqas39LoooBa17lL54UA1n61DTg=;
        b=VBchsCOEI/qRlRkUC5bCcthChQqZnZ6ThaiU3amo02dfSwtCDzSU9hiSENAuqx5vW+
         Pfgr3y8HEFwb4FYlpKZH1g5Rx/KXAqu5uX6hF+FD1Vq+HBPIpnRNHavOBphSiKwK0Xt+
         2Tax9JrGikKjL3DgppTcgEmN/SWkT6BlRri/Xrg6v49cPae3yq885+KhXKYZqiEt3E4A
         j+OnlhfJBhYralTVXtfPT+MiEYbUPhLJQmW3iMRIkUy/K11mVBUYqHi6jAhr3pnk/tP+
         oWwu4WCOFUFPmgB2S11qqaS9u2Wew8wnwxveLFk//36aH4BS4PPByNcYgS/6Fwq3C5xG
         ZI2g==
X-Gm-Message-State: AOJu0YwOoeckzYmmByzJxx2hDF6lHapfKpwd+D5J2NvcC1kIS+koYFA/
	Vo9sw1TQ7BtLviq0gnYfo4wLSTtoYkz0dMOgiREucBVwMaiYvJfTTX1Z
X-Gm-Gg: ASbGnctoziPkr/Me4Ed4MLOjSOyelD89Eq6sB50Ky2qIhrvz3MnNmAccJO9pjFOWb88
	AGLLX8OaCGLOU5hV4lCYQn/9foicz5cQDqhLnaLP0whJX37XofcXcxXwUsdoC7RYeucxRieprFV
	wDFuP2u1JyqECmmg3klOeZu+PIUCryLBYS8ymmbm6nLUZggdqzwJ1X0yKvZ37MZUjNiWk4/+RVP
	1g2T3Mt1sw2mI/wKBmk9bJ0RKKXPmq8VvI/J8ns+c67qgUJVqTNqed2eDQfWxWegXfDfWHqF78e
	b2dRytN6hehl+F5FSoFzjdtGH3Fex45MjqCEVilsBFnOHXZKnhtQZXGRlPLYAQl4RRbfPODutKi
	uzWe5GSWpi+KBQaXK
X-Google-Smtp-Source: AGHT+IGHOshuP7YBnHS4bwq4lXE1CY/tP66wKaiE9txb8zgk0TQu3I7y9ymfYZ51czQ9Ic7vtY1HRQ==
X-Received: by 2002:a17:902:ecd0:b0:224:1eab:97b2 with SMTP id d9443c01a7336-2366b19ec77mr285492755ad.53.1750277865521;
        Wed, 18 Jun 2025 13:17:45 -0700 (PDT)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:920f:fb70:f9dc:d1ca])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365deca0f8sm105358695ad.196.2025.06.18.13.17.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 13:17:45 -0700 (PDT)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: williams@redhat.com,
	jkacur@redhat.com
Cc: linux-rt-users@vger.kernel.org,
	jserv@ccns.ncku.edu.tw,
	yphbchou0911@gmail.com
Subject: [PATCH 0/1] Makefile: Temporarily suppress -Werror=unused-result
Date: Thu, 19 Jun 2025 04:17:37 +0800
Message-ID: <20250618201738.635735-1-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds -Wno-error=unused-result to the Makefile to allow rt-tests
to build on glibc >= 2.41, where functions like write(), system(), and
ftruncate() are annotated with warn_unused_result. The build currently
fails due to these ignored return values being treated as fatal errors
under -Werror.

This change serves as a temporary workaround. A follow-up patch will
address proper error checking at each affected call site.

Thanks.

-chengyang

---

Cheng-Yang Chou (1):
  Makefile: Use -Wno-error=unused-result

 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.48.1

