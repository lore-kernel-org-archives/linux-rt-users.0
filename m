Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05873387588
	for <linux-rt-users@vger.kernel.org>; Tue, 30 Jun 2026 16:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782837938; cv=none; b=Amcn0OTJdMcTKmyQYwyunCFR4H2xbaslFmbv1ssuBat/p4CrnglEWeac/Cw0JFtVpIUeo86hIzu3K0CdxU/lRRy49pXul6mGrSjjp0JfPRjXp5DTuq4RmDGX4C1xj73umbOyXatBmmLXXgshN1/o3pxPf2WrmMgLyzh6Oyz47WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782837938; c=relaxed/simple;
	bh=75mR/KndX6/LAtrnWmTqsAtMGk3jB8qQM7ksfPpBSU8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GxIPNybG71YHpJwTRL39SKdv/uJd0fDoIpWimNb4076tD5xLSy3/+Pn2sl3M4tRpAVySxK8pDGynIFNF/plUVOx0O6X2Vm7Z/wmpFP0KkfhyExet+Scd2hJfiqdIUUZVHFiDM+k8zHjiS+20xtAuy2ZJL4qBlDYbXToGDCqvpkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a/c8BlyR; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a/c8BlyR"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-51c1805b8a7so9929011cf.3
        for <linux-rt-users@vger.kernel.org>; Tue, 30 Jun 2026 09:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782837936; x=1783442736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LPjo67SveNvIpbqCU0SZWhCDZtIdmPRyJTIYCMnTCMw=;
        b=a/c8BlyRHz2eO3Zz1IrcIAWVDpCxO/r+WlPf6yeTRzfMPmU/vI6qFUuHQBCGSicwxJ
         9KzmOpj7xFSr0QuTm1ey/Hqnh+M3Erh1Qu1wRLTOTPuJhovSLFgkd/FDL9dIbxBWVnxK
         nyv1tGuIymPw3jmybfJ26YpL3y1N0+Za1l8EMFve+nT9W3CCIBEQxKoN56IdYstPLeXV
         I8ZR+f9U2JmqPW097m/Bwe0n1gNDJ+Y5MrWbbuL8tIicrrmbHSTCpv2PVimpo0HvxfDt
         Vxy1P/Q9mhogqMq74XFYxe5YQFMAA7yiH6420cwlJ/wjMWMWc3sV/fWXdgtgAVX2ietf
         oNGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782837936; x=1783442736;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LPjo67SveNvIpbqCU0SZWhCDZtIdmPRyJTIYCMnTCMw=;
        b=aulw/8EMMnXKZVGQyJAdvIHB5c3JJ8xODeenZjNQyhRx1qi800XlVbM7NS035A4ZIu
         1Fj9p82U/h96CA206oupNDJW4RI3M4ZA9Yk7cBv0Ar2eSe3hUWhR+UI6jP1d/39e218E
         RkJmoF0RAGZnqViqKit2GVOOM3IQohB1ynV3uC/P9NbRSbRFey86gyJfE59GCGCyyS90
         6FvyDTIH2TlXBBPiEw2kof0++x+uTNjSzhwVIqcRXax/LtN5WfnWX5rj9hhtIRAFdZB2
         tRs/lSgYqabBX+bBhkIIlZ4RJbYt0GZmQSUAJklCsiGMgfX73hBb3v95l/uOEmES+683
         D55A==
X-Gm-Message-State: AOJu0YxTiNBlMK21cLAU8V/0/EywOxEPvS1c3ngCE1q0jnHJ6p9/5o/S
	Hr/wuypAS8Q6LaWiXtKONylpXO+/qpCRKEm6qJyFycYpKY5EHrxnf3CIH8Ucxw==
X-Gm-Gg: AfdE7cnEteS8xBYvlocbMqPv4dL6JHN7ZD4Gyldi/sDwSd9v7uE0lHFQR41aEsOXKIb
	3A9wOHgcevmAe21T8xELn59et+b9x8XlUGmxZC6OaZxFqCOz3ojcvCtXQ2XX25PGxddMP1naE26
	CcK3jdJXL2OvEb6IMC5/PjqDeIKPsY9X0WZJUl1ATmX+Vopps6wiLixSYS+PHNCPu28JU5R0kp4
	bF4JFhoDuXwmQ/KbY7Dwr+bWQT92rbc+c8v9nl2OEduaH9xJLof/1b2O+BvdeAzV6TP2M5PyFGj
	08A/wxDEskHuviXdcdJhuXPoTcT922JZ1lmVUF/2yDVPOZ20vtbjavnRBcYDf1cs4/bET5qmMuZ
	8KfyM6SZThNUbQSe1d+oT6v8Bsq9Mw6d07EB1LDwA+7anMN/xeAaZaAEyK9ZKUpwraV92v+zjOV
	YUQcMTfmUc8WlZNsx9xNMzl5hvJQISKcFF4XyOuni3SutdehWEknQlZcRQfJC423zAodg2YH8oK
	b7scw2z8D2cU6J0qrtB
X-Received: by 2002:a05:622a:15cb:b0:51a:8c86:bd44 with SMTP id d75a77b69052e-51c1ca6e8b5mr18396251cf.65.1782837930546;
        Tue, 30 Jun 2026 09:45:30 -0700 (PDT)
Received: from Cumhall.redhat.com ([216.209.112.119])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51c1080d4f4sm22722361cf.4.2026.06.30.09.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 09:45:28 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Derek Barbosa <debarbos@redhat.com>,
	Clark Williams <williams@redhat.com>,
	"Luis Claudio R . Goncalves" <lclaudio@uudg.org>
Subject: [PATCH 4/5] pi_stress: Fix error and debug message formatting
Date: Tue, 30 Jun 2026 12:45:01 -0400
Message-ID: <20260630164502.95740-5-jkacur@redhat.com>
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

Fix three message formatting issues:

1. Incorrect barrier name in error message (line 212): The error
   referenced "all_threads_ready" but was actually checking
   "all_threads_done"

2. Typo in SCHED_DEADLINE error message (line 746): Fixed malformed
   parenthesis in "affinity*dl)" to "affinity (dl)"

3. Wrong format specifier (line 808): Variable 'count' is unsigned long
   but was using %d instead of %lu

These are cosmetic fixes that improve debugging clarity but don't
affect program behavior.

Assisted-by: Claude:claude-sonnet-4-5
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/pi_tests/pi_stress.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/pi_tests/pi_stress.c b/src/pi_tests/pi_stress.c
index 675953923c3a..45ccac739646 100644
--- a/src/pi_tests/pi_stress.c
+++ b/src/pi_tests/pi_stress.c
@@ -209,7 +209,7 @@ int main(int argc, char **argv)
 		pi_info("waiting for all threads to complete\n");
 		status = pthread_barrier_wait(&all_threads_done);
 		if (status && status != PTHREAD_BARRIER_SERIAL_THREAD) {
-			pi_error("%s: pthread_barrier_wait(all_threads_ready): 0x%x\n", __func__, status);
+			pi_error("%s: pthread_barrier_wait(all_threads_done): 0x%x\n", __func__, status);
 			return FAILURE;
 		}
 		pi_info("All threads terminated!\n");
@@ -743,7 +743,7 @@ void *high_priority(void *arg)
 		status = sched_setaffinity(0, sizeof(cpu_set_t), &cpu_mask);
 		if (status < 0) {
 			pi_error
-			    ("high_priority[%d]: set cpu affinity*dl): %x\n",
+			    ("high_priority[%d]: set cpu affinity (dl): %x\n",
 			    p->id, status);
 			return NULL;
 		}
@@ -805,7 +805,7 @@ void *high_priority(void *arg)
 			}
 			pthread_mutex_unlock(&shutdown_mtx);
 		}
-		pi_debug("high_priority[%d]: entering start state (%d)\n", p->id,
+		pi_debug("high_priority[%d]: entering start state (%lu)\n", p->id,
 		      count++);
 		status = pthread_barrier_wait(&p->start_barrier);
 		if (status && status != PTHREAD_BARRIER_SERIAL_THREAD) {
-- 
2.54.0

