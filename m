Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2612D7B8
	for <linux-rt-users@vger.kernel.org>; Fri,  5 Apr 2024 22:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712357225; cv=none; b=oU+SIv+thDA4mhG/RUbI8PdnY6ra5DaexVZGo0HmsUTa30mKPss22tS380iOnyvZ1MTX1UlpxNBptGyhHpehixMj7sk3PWPX4nkoJvJnfHETSCKLNef0wPdvIKkmSUezTLZoxvnq6S8w3fKTIml5BJiX7HQcnqd3+q+S1w5e3co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712357225; c=relaxed/simple;
	bh=gWzNW9VtaMAaJXZrUQlEddyamPHUtTry77wOIm1givk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dF89S0INS7tDcsaRaH1mx29BhwP5L2SuKA6MAKztdlwcltzQAQgTo2uNlzLDoFIB3ZTqnQvIdpeJhysGvCiFCuPEoggnEZ/k6LDs3PbDM5lLPC8Q2LNg8b0UeKqaTTlR7oRrPlXrkG/HofxvpSMYc1WLcLjSYQk31MRYtaU8WiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VE5sJS5K; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VE5sJS5K"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6994bcf7e80so2255866d6.0
        for <linux-rt-users@vger.kernel.org>; Fri, 05 Apr 2024 15:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712357222; x=1712962022; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=r6nIIr3vO7jbMU2OPxsETnMQ10usCiSxLhZE/m/nQc4=;
        b=VE5sJS5KyKkH201nh69UyE8ZS3zDqL88dBC4mo6b2XDUBVj1x6LuqjeL4M1J7FE83e
         zXaf9Z5vj2eDS6Gt2r97jtUhY3GiNF7EA7/C/Jlj02bx7cr0c1nZtH/H6/BGS6eGaLnD
         JvdpDWqki6Xdt5l8yLtHpGrMzb/vAJWEcYL23wzY8vv3FqHijKF9zSu09LJYfwfyd4/a
         4IA20nd0DTFaaKiih3N7Wn8qktFuGgsoEMJi8832t59o51Rn8sycOGncfVU40f+Ia7YR
         R6wzKXC7F0ETiD8L2WpHAWsZ6IUST+YUn7rc4Bta15/0MzW3STPb1HwsnS2LrEnjRP1z
         UqfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712357222; x=1712962022;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r6nIIr3vO7jbMU2OPxsETnMQ10usCiSxLhZE/m/nQc4=;
        b=ABPpGHRu5yoN8+C8PV9rg7JxVjSKdJX79T52eqq6SBjDBOVaYF549MPSEl6ony1S+m
         Vct2EZiJ9szzu4I2W5jfqnFalb+n92A4zbrxpn6OmdO9UfMNPPQjGZ80Zcs+Vp0SLs6V
         Oyxa6/f9C7M1GnWvvGfQKTmLWgFY7tbyfer3f833C2wNmw+lhIODQEisWx1krU2iUvzI
         pCN8nZLBxWekmcu9YoMkOooDYZnrPtr96e0KJ4NfUil64jqYU05GXHL+OqEyGAxTg/PK
         SLe9dbM6mTL5BHVnMoxvoIKPS2k/BPokaE65JyEiZh8zDEPv0+xXN0DVIRcWsVvQfJn8
         Gaxg==
X-Gm-Message-State: AOJu0Yz1/s13PJJyyM91SUAjxZgQSXzsUO6tUfQUy78iaOPi/Lltq92x
	9355x1gEFOFHjDHf9SM5YiShiVMbHJO6ul80Dv785NTcrmb6PIGdXHO23rLa
X-Google-Smtp-Source: AGHT+IGMDoRecUFrQeJ7P8owJOWzUqYm1llVKpGjj7Qt6TYdlrjjjdZ2C00SrCr/jzg0gmS8+nk1VA==
X-Received: by 2002:ad4:5aa1:0:b0:699:28f1:49a1 with SMTP id u1-20020ad45aa1000000b0069928f149a1mr4909582qvg.21.1712357222171;
        Fri, 05 Apr 2024 15:47:02 -0700 (PDT)
Received: from fionn.redhat.com ([184.147.142.166])
        by smtp.gmail.com with ESMTPSA id v10-20020ad4528a000000b0069940887de5sm781226qvr.109.2024.04.05.15.47.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 15:47:01 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: RT <linux-rt-users@vger.kernel.org>
Cc: John Kacur <jkacur@redhat.com>
Subject: [PATCH] rt-tests:ssdd: Ensure there are one or more iterations
Date: Fri,  5 Apr 2024 18:46:47 -0400
Message-ID: <20240405224647.102211-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There must be one or more iterations, prevent the user from
entering a number less than one

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/ssdd/ssdd.8 | 2 ++
 src/ssdd/ssdd.c | 5 ++++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/src/ssdd/ssdd.8 b/src/ssdd/ssdd.8
index e6be5ef6a27d..71cb71ad0817 100644
--- a/src/ssdd/ssdd.8
+++ b/src/ssdd/ssdd.8
@@ -26,6 +26,8 @@ number of PTRACE_SINGLESTEP iterations to do before declaring
 success, for each tracer tracee pair set up.
 .br
 Default is 10,000.
+.br
+NUM must be at least 1
 .TP
 .B \-\-json=FILENAME
 Write final results into FILENAME, JSON formatted.
diff --git a/src/ssdd/ssdd.c b/src/ssdd/ssdd.c
index cad901b563d8..45f6a23910ca 100644
--- a/src/ssdd/ssdd.c
+++ b/src/ssdd/ssdd.c
@@ -80,7 +80,7 @@ static void usage(int error)
 	       "-h       --help            print this message\n"
 	       "         --json=FILENAME   write final results into FILENAME, JSON formatted\n"
 	       "-q       --quiet           suppress running output\n"
-	       "-i       --iters=NUM       number of iterations\n"
+	       "-i       --iters=NUM       number of iterations, NUM must be at least 1\n"
 	       );
 	exit(error);
 }
@@ -331,6 +331,9 @@ int main(int argc, char **argv)
 		case 'i':
 		case OPT_NITERS:
 			nsteps = atoi(optarg);
+			if (nsteps < 1) {
+				usage(0);
+			}
 			break;
 		default:
 			usage(1);
-- 
2.44.0

