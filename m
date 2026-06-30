Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7093D75C2
	for <linux-rt-users@vger.kernel.org>; Tue, 30 Jun 2026 16:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782837930; cv=none; b=PirhYIA6m5W1xmQpx0lErl2EcbrsibdDJyWEUnoAIIuALbnnmlNniPlM/tkNS/LDznwZN9dVQvNk1A4eZlp6h1gaSV2dGYwPuUvb2N6H0aI+c3zM8GbCiN1ZO2QhwnlxOKymO7apLFJm0hksuPg7rKjBlBLle4pBLdUpPsR+Dj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782837930; c=relaxed/simple;
	bh=hY3mFRw7yI9YjqT6AKo9JF76KKOZDUXbBwsDobZvBlE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l7uNjoR58tSSdjo7/y+Ir1HCfEBh5l5RsnoStU5Nw//3xqcNl51w+Q1EWMY6ev5s2iWq9fJaS2wmvTJ8rD83JoMay+RcljObYlv+cOViTivGhlyz1aYHCU5m9O/4W3l5axHjpkKvllYICNR3npCHZmw9hoC+5uyWlNl0ayN33bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g376cf3e; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g376cf3e"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-51c0c68aa31so17015131cf.3
        for <linux-rt-users@vger.kernel.org>; Tue, 30 Jun 2026 09:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782837928; x=1783442728; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bx5ceoXlZ0zb3kJ5DQ2hgYj18ekWZldLD4/hsSI/+pk=;
        b=g376cf3eOMW82suZYtLFGz/8mMIb21oPiBigcKBbe2WPy/wzY7hmF3vwq+hmmM7p68
         teVpkSCbdlyCiStv6ncy1+L6PYvP1tKJySJyM3fFF62O0oY2S42b+ctflK3WOmOeqFTn
         LYJcCqWHnlTGiDwC7MmnbZUn6R2CLtean4EZK2NhWmpewkRpzo0E2akeO9DlAg8GtiG3
         LMPDfaht3It59mzpRjv8r2oPcAYID4Att5tN5oa3a6KXcAuCy+aQZprXOH1TH6VL+kgf
         nnMy1vD4Nsj5Gh3/7kYOZIdhIep1ZZRBt4x5c+nyccMKhnTEh2ypd6hHl6KfuLuRyZpu
         LOUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782837928; x=1783442728;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bx5ceoXlZ0zb3kJ5DQ2hgYj18ekWZldLD4/hsSI/+pk=;
        b=dw/6dN9jypQxRX9TUgIzcoYK0jn/7AiGILli3VsR/TC/smm4Ob+//xpRVL/dybOOkv
         LT4MLW3Iz5MRBpiswNdDqddPQz3eke5V63J3BVlCTYi93Zbfn/x+M5mAzTC7fEWBJ7H5
         p8ej8e9sLXw/ldpL/vdwF6T4USeIGerTvCUm2phmrhZhiikMslIqMqCj4AKKg+NzmD3Y
         zQiqhB5s61T5RQfFIrV9xvSqqX6wpe3KSSZ9Y4q/Gj/yYzIB50jNSmMJQ/coUwzWA/qJ
         UIlduN4xjFLYYL4uPEFpvdCObTyPLcB12vUvL+cBeacQqK1hacINZ8OnOrLUKw/MCMio
         D3bQ==
X-Gm-Message-State: AOJu0YyuD7c0KNwWJBnwTk4EhagqkQ6DfQLsKVGbu2CnMKlP5xcNCUXG
	7mJMODZsC9V++SGBCt20n6PeNrgaPPY0xevpPQywypQozi47DHUiTHkt1DsF+g==
X-Gm-Gg: AfdE7cmnc+OOtyoXd08AvpYj+OQ9jwq4sh8O0nRpM2+sIkSDmYxekV6nWnwTkO71vu5
	Q5ZZrQ4WYrHX2Ujzbo+hleFNJ0MekNusVeo3NItYdN3thol87vr3pmP3ajhuie++9Eb3b0RFGPn
	XBAnlBkOfBvyUA2ugYJom/g/wou1/6+6vKMR3WDR8TITU5EL6t5c4XvXN+gB0NImlhLgpzHfMe/
	welwALilu/3JvvhLCpDXM//dp3dUBsV3KayUIJC1baU1gcR5XRrCYwLGw30Uird09CmyVRukAW7
	/RLmRIHOCs4dk6aXAOJguoK62v/ianOAg1VphnJKHDrR6EaY7yhoGl6GbCTJEt+C2Y+El/sduyj
	tQETajb/arpCC/WGQgUIrIuSkPJkpuCB2HSlFfstdI7mDAIxXnVFiW7N3GxKsoZRrqugaiPf0m5
	qbw5qCzCHaywS76LQ5BJ4+jWi1hBSijCw8yxmxv2PN6rYsnrFQi6VqhRpwt8H0OMyrGV8vxDB4W
	6dTiZ/DvA==
X-Received: by 2002:a05:622a:1a84:b0:51a:8c9b:649c with SMTP id d75a77b69052e-51c108d29e0mr56310511cf.64.1782837927595;
        Tue, 30 Jun 2026 09:45:27 -0700 (PDT)
Received: from Cumhall.redhat.com ([216.209.112.119])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51c1080d4f4sm22722361cf.4.2026.06.30.09.45.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 09:45:26 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Derek Barbosa <debarbos@redhat.com>,
	Clark Williams <williams@redhat.com>,
	"Luis Claudio R . Goncalves" <lclaudio@uudg.org>
Subject: [PATCH 3/5] pi_stress: Improve error message for permission failures
Date: Tue, 30 Jun 2026 12:45:00 -0400
Message-ID: <20260630164502.95740-4-jkacur@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260630164502.95740-1-jkacur@redhat.com>
References: <20260630164502.95740-1-jkacur@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When pi_stress fails to set real-time scheduling priority, it printed
a cryptic hex error code (0x1) that didn't explain what went wrong or
how to fix it.

Replace the error message with a clear explanation that indicates the
failure reason and suggests running with root privileges.

Before:
    main: boosting to max priority: 0x1

After:
    Failed to set real-time priority: Operation not permitted
    Please run with root privileges to set real-time priorities.

Assisted-by: Claude:claude-sonnet-4-5
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/pi_tests/pi_stress.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/pi_tests/pi_stress.c b/src/pi_tests/pi_stress.c
index c8c895a71e44..675953923c3a 100644
--- a/src/pi_tests/pi_stress.c
+++ b/src/pi_tests/pi_stress.c
@@ -134,8 +134,8 @@ int main(int argc, char **argv)
 	status = pthread_setschedparam(pthread_self(), admin_sa.sched_policy,
 				       &thread_param);
 	if (status) {
-		pi_error("%s: boosting to max priority: 0x%x\n", __func__,
-			 status);
+		pi_error("Failed to set real-time priority: %s\n", strerror(status));
+		pi_error("Please run with root privileges to set real-time priorities.\n");
 		return FAILURE;
 	}
 	/* block unwanted signals */
-- 
2.54.0

