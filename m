Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C710277C8F
	for <linux-rt-users@vger.kernel.org>; Sat, 12 Jul 2025 13:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752327771; cv=none; b=ZsBk4cP70tAIwEJVgINh2JmfBdf9X7J65Ggrtq7voDtXMxXh6iefXc4ml58z8XtzSDfz7dBymjHXV+PZDaD9pc/pAidf8S6F0NFJ4r3mpFOY65m42Spr2aj7jy+h/Tlu+z9fFfXTy+ZscuEsF3bp5NJPEYPEBaFovEoa5CuqffE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752327771; c=relaxed/simple;
	bh=N19n9xIOqAui9pMfRG2oYrw2CL8y39Nkmr9bIjXSdwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JNi05L0F5sZyGgasIFQ7M/JWf+7LCaz/kcQG/0DxSo4qQkh5XO5dT5i4i/Y8Nf+PRrGNiDx61Sq5dgoG82U0P09kKpC69G3On4758ET1jl0CT0zStqg1PoVJnojK0vEfPN/PHn4kfv/aapg5ZKJB63tnJEGzR+i8nPjt5SzPVpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TZYycFCw; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TZYycFCw"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-23526264386so27214615ad.2
        for <linux-rt-users@vger.kernel.org>; Sat, 12 Jul 2025 06:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752327769; x=1752932569; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L4VxBgM80QEk0EY5WC78cE9sWpmgbmqTdm8Ze6VurzI=;
        b=TZYycFCwkmwxVDWBRxnWjroFQukdUFWPWtezl85wy9Ai6bvmOxCIuF+2GiewsWe3MF
         3LuNtI4G1sF8Njv8Nj3zuVjOnlk7aiLSMcWU0Q5YzBILQ3ATL4RP7qQEQ5Uulz5hRN4+
         mYDgfXzFuIIa5gIh3CqihLffAJ9tEOfuxhxRDLulrtdUQu5rHqFHRHIheNdZPi9plRAh
         26ozg8Kw2KybJv1wIpeX0lThaUO/tHTpV6vNNeFquIV0kSefHIrJ0Ibx+5kDx2p8eV2g
         L5scZmtwjsocq7GiIyQLNTQUP3hPynppzO0GPmCBWPHs+Lh9XddwKYw1W0Jn7V44j2wX
         W4rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752327769; x=1752932569;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L4VxBgM80QEk0EY5WC78cE9sWpmgbmqTdm8Ze6VurzI=;
        b=peeyv3OS5iaY73iJIAx/Kl0WTHrBI4AoYfLLf4TEOOszZqiPf9F68lLB4EyEuORlJI
         y97LoO56khZPfiDm+74GvCaB7iySxa36AlsnzuxVYbIQPDmC3+0FdM8/gvKANUNsguQm
         B6eTDrP2IF4BxDbeDDv5VSBchTrktzSMMp2TRG49AKuGEtWBY9W+jKIb4mPxDyzNYwiU
         Y802KEZIz5twHfO3ty5bk9OdnHJoj8x16jzE8e8jsP6/no8yQ8g4xDHpID82vra//vP+
         0cSHADtDWe0LyuOhnq9rCpGyu8QcaVxLVTpni071rB4Jkoq/egBKGWMQUUDIfe9CxVo4
         AwmQ==
X-Gm-Message-State: AOJu0YyTmhGXWT7/+VHYcvT516vkbCDapwDMHtM3eL/JIitsnC2+8ASF
	IWdJJiOzr5i16v1wkX70GQkLJX1oFyQSiH6pvQRSseuQLUKOvYeCKQCm
X-Gm-Gg: ASbGncvAjzVsjL+IvXWMh/j8Sxl8Uqtnv3BIT3iAP04yp6GrmmGDyXDIt0+sopHgcfx
	zclDTXtMH9gMe3wtuWLMhuXO8/uLTNUoy/lRAy4vDhl7qDMGr2cAC3yPZWhKdOGJQ+0+WTeVtZ8
	9sfqkP3DUm9G1enbpM38VlTMWdiYEa5kER6bJ3qrhHa9/ghglbE6kmUU6E207Gm8FO60FGqgsCR
	p3VMro43apm4nwqGwcfKgyVZdgH+WRb4+mo9qjFnkmEA83cyLsVZih45RraJ0QvYrABGkwedECx
	KhM28wvcwvNVC1Q/QZ3VFeRBfIaE5ISmQX37QYdVOyw+aEYcprMGR6/iDHYHlkITV9mpj0zakHk
	QKkZDo6TnRnMTIRAOJoAw0c20M67G4VFru+e6DpwSix/vq53n1JcP
X-Google-Smtp-Source: AGHT+IE1SAeVajwYXBARy+b2xefE0sCHzcuVNLOmOQTVxctjbekJaALUVv3rky9Uag/g/SBYMkBy0w==
X-Received: by 2002:a17:903:f87:b0:223:619e:71da with SMTP id d9443c01a7336-23dee28523bmr110910135ad.49.1752327768817;
        Sat, 12 Jul 2025 06:42:48 -0700 (PDT)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:90c1:8214:37cf:b3e5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de42ae865sm64193205ad.72.2025.07.12.06.42.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Jul 2025 06:42:48 -0700 (PDT)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: williams@redhat.com,
	jkacur@redhat.com
Cc: linux-rt-users@vger.kernel.org,
	jserv@ccns.ncku.edu.tw,
	yphbchou0911@gmail.com
Subject: [PATCH 7/8] sigwaittest.c: Suppress warning
Date: Sat, 12 Jul 2025 21:42:12 +0800
Message-ID: <20250712134213.58582-8-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250712134213.58582-1-yphbchou0911@gmail.com>
References: <20250712134213.58582-1-yphbchou0911@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
---
 src/sigwaittest/sigwaittest.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/src/sigwaittest/sigwaittest.c b/src/sigwaittest/sigwaittest.c
index 026cc81..3944b54 100644
--- a/src/sigwaittest/sigwaittest.c
+++ b/src/sigwaittest/sigwaittest.c
@@ -72,6 +72,7 @@ void *semathread(void *param)
 	cpu_set_t mask;
 	int policy = SCHED_FIFO;
 	struct sched_param schedp;
+	int ret;
 
 	memset(&schedp, 0, sizeof(schedp));
 	schedp.sched_priority = par->priority;
@@ -168,7 +169,10 @@ void *semathread(void *param)
 				int tracing_enabled =
 				    open(tracing_enabled_file, O_WRONLY);
 				if (tracing_enabled >= 0) {
-					write(tracing_enabled, "0", 1);
+					ret = write(tracing_enabled, "0", 1);
+					if (ret < 0)
+						fatal("Could not write to %s: %s\n",
+						      tracing_enabled_file, strerror(errno));
 					close(tracing_enabled);
 				} else
 					fatal("Could not access %s\n",
@@ -489,7 +493,12 @@ int main(int argc, char *argv[])
 			fprintf(stderr, "Could not create shared memory\n");
 			return 1;
 		}
-		ftruncate(shmem, totalsize);
+		if (ftruncate(shmem, totalsize) == -1) {
+			perror("ftruncate failed");
+			close(shmem);
+			shm_unlink("/sigwaittest");
+			return 1;
+		}
 		param = mmap(0, totalsize, PROT_READ|PROT_WRITE, MAP_SHARED,
 		    shmem, 0);
 		if (param == MAP_FAILED) {
-- 
2.48.1

