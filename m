Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0E333C513
	for <linux-rt-users@vger.kernel.org>; Fri,  7 Nov 2025 18:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762541897; cv=none; b=L0MqPFFMA5GcBc2IQZA6nBzOIeBSM+mcBVo9N2SAXoPWZ4mm3/FSD91naPrncrfRHTGFwcC/41i8fTVxrlBrXflZsbF/QsGYPW9XRsL21bPXkE8MbOB8HqlDt+tndn77tyMQb1pz+GH46a/nx+mK816J9JnTlKSE70g035ZnUUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762541897; c=relaxed/simple;
	bh=lMR5y6YleQ52BNHYgewaiCpAinChRaUtuScmfjoXoQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KeuyFRf7OcBd41riEvjxReuNEwCakzqYeqjsoa3Or510JPatE9oZ9tonPMZTm7iYy/62WWu8xjqXSi6b7LLnEPbGzQsQ/nx4NdZsNvm/5/4E7zWuNcwI8YyQNyipFxdXiE2lqqOfP+sJ5edFm3CKXxbb9BBV3ws2anYGZAChRAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ofj9St7h; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ofj9St7h"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8b22efd44d8so121765085a.3
        for <linux-rt-users@vger.kernel.org>; Fri, 07 Nov 2025 10:58:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762541894; x=1763146694; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7nfSwcz9J9VcQ+mqfljjq1BV6BnTEfrK/42uQspnZyM=;
        b=Ofj9St7h96eysqXIE3rBspQ7CsNPwxCH0eRVrQ2kRZyYoZVQfqzvoF2QaHmiO5Imng
         NVJq+cjkSNenHt405y1lK/84lnV3ybGCaNucNOrumvRpiySwQZbIRAxyOvpv4l97+5HW
         RNIMZ+wFYZPE1O2sRDC6Dj+4DVyMxs4VHBSzV4xPfTPOcEUpqX/jb93E92jjkvhsmXCt
         H1KQday8tp2uDZksq5/WqmTbzTanuWJOsq0FMQtAdXFy4EMfeORAnMz3jZTgTy0Hq4Ko
         vqZjydfjAcMYptWBdegnakGxdfl33nNw/rvX2BmIkTrI27/HO+sm1mbX5zjOfQFPsZkX
         Q+mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762541894; x=1763146694;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7nfSwcz9J9VcQ+mqfljjq1BV6BnTEfrK/42uQspnZyM=;
        b=nrs75V4tkzQWHudavvChh6/0VqZzJKAdK2UZiC2xZ1jQaYEmEjMePKdVPO8e1AnO4w
         8EL4EpCmg394LxlWI7z2QBo5sQQlrcZ60GajvoID92q9nhZYcAhqX3XQ1oPo5x+6NI56
         Sh4WO7dJmtRGG1A7fDNAcmE4ptMYhOmXErCSCxvrvInDUtVBG3m5IJUm0NicFQisVOcs
         osNZHKSkVb3OYS20b74PKtdi7RruVAWnZRDBQCY4lejQ26NAHXf20OreVZsXB9uudLgY
         SaOGTTnEj6LfJOC6d0upyn9vugFE3AfA7x0NJf5qIbdNPK1wnd5yvluGhZQrKMCKfd4G
         FHfQ==
X-Gm-Message-State: AOJu0YxuMr0kRHQKvug6CcE/Mq4NeraV/Fatk6T96/Lh/q7VOCCEW6JL
	WQStyMrIHMlXP9XnWki648LFFtJrJNYL9UGOlDQiCu351WD1mfo/gaMhcwkLiFBe
X-Gm-Gg: ASbGncuuAjkfH5vfelppzvliM9e5jdicdpS1X0EH74dGz71aa6wBPT9VQ0PJzPIm7Ff
	fbKR8thNlNYgr3MeKgdDPTgxJkhJkaEU1rRJ7iR3K6450NiZC5WK3H/WRKX6c5MfQImkMlfChVV
	f15i5Meovn7/Iv9m0ed68DziPn6h0vv7I5q7HUkPiRhHFpDiF7sCvEqQNHOGAMA0wl9kbIs0c1Z
	XvZ9OWatYoy9Hdfoh4aPIka8pyYzpOYy89By+r/ATpSsiYnz+G37st3OU1l301+AvkN1nGxMU7D
	aHqLoPnLXR2emKslCz2PUe9XcAwe/l2z5fCzYpZahTOUZB3DZhlqkezPT8NC90fJqqYrYsD/JQJ
	jrnAPj37mKs90/21kDwmjxn3Neu/UDvqX8zo1IjI65TPKXPCHQs9yu8yHt2pK/yE=
X-Google-Smtp-Source: AGHT+IEi4fiOB6oiAoYQ/EoyRodB6x/EAE7b3l3BWNeEpBiv9EcO+FrBmpUAoaPkUAzXxEy78Nw//w==
X-Received: by 2002:a05:620a:294f:b0:7e8:46ff:baac with SMTP id af79cd13be357-8b257ee046bmr51318085a.1.1762541894213;
        Fri, 07 Nov 2025 10:58:14 -0800 (PST)
Received: from fionn ([174.88.40.44])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b235828514sm458103785a.53.2025.11.07.10.58.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 10:58:13 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Cc: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: [PATCH 15/23] tuna: Add -U and -K to the spread command
Date: Fri,  7 Nov 2025 13:57:24 -0500
Message-ID: <20251107185732.23992-16-jkacur@redhat.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251107185732.23992-1-jkacur@redhat.com>
References: <20251107185732.23992-1-jkacur@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 4e10e5b34593052e6ce4a166796b10c72f978efd
add the feature
	-U, --no_uthreads	Operations will not affect user threads
	-K, --no_kthreads	Operations will not affect kernel
threads

to the move command

This also works for the spread command but the arguments need to be
added. Without this you also get an
AttributeError: 'Namespace' object has no attribute 'uthreads'

Fix this by adding the options to the spread group for argparse.

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 tuna-cmd.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tuna-cmd.py b/tuna-cmd.py
index d0a3e6b7dbf8..9f5ce918054d 100755
--- a/tuna-cmd.py
+++ b/tuna-cmd.py
@@ -183,6 +183,8 @@ def gen_parser():
     spread_group.add_argument('-N', '--nohz_full', **MODS['nohz_full'])
     spread.add_argument('-t', '--threads', **MODS['threads'])
     spread.add_argument('-q', '--irqs', **MODS['irqs'])
+    spread.add_argument('-U', '--no_uthreads', **MODS['no_uthreads'])
+    spread.add_argument('-K', '--no_kthreads', **MODS['no_kthreads'])
 
     priority.add_argument('priority', **POS['priority'])
     priority.add_argument('-t', '--threads', **MODS['threads'], required=True)
-- 
2.51.1

