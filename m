Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E309C28D822
	for <linux-rt-users@vger.kernel.org>; Wed, 16 Jul 2025 20:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752697435; cv=none; b=k1SfcbwfhgV0+Bb9FOMGPZHSWVy5AWQ9xCAGPugat2leV+UJRtod5oyRkUJamhNE+A1XTZx/zMi8Ewa1eFG0KdIqEq88qlHPR+gsfJPGxGQqW6NAK+AQwEUQl8rElXIAn3gFI2uYoYNUR8bIbgdO2t9O2TCImx/mQzi5bNsoi8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752697435; c=relaxed/simple;
	bh=M2tPTJcarzECKPeHn3rixOKiyqGHenpc8NVLQt7TDcE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lkq2wcCYMXg/ngs77sxmhe+9Cb0yPiT+EOSNezOb5JwPHQN/e8uHqdPix6cvSJY0nb59p+mEf6R+PBZ8KZwE4drtoDK6zySyi/pIJZz5jKmU/X2oXio67331dzGhpm2I7XHQtfoEsxSYovIUi14aF7LKzgA1grV9SuMuQeFacAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ecYMO3KY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ecYMO3KY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752697432;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Mr/+do2GDPWhwVd6V8Vx9NSKkTbStmVd0u0erxRoPLA=;
	b=ecYMO3KYpdLxnnRn5u6zw+rScEdMeW/6rADthvcNQTfRljPRc1nroXx2k5cRfXMIi/9u+c
	LzVzknDpd6LumyZAMRZM8OSeSeo+Bo1kVpwCb6kAPVnDQBREv7jtcry6PUUwXvbUVp1e5H
	ffXRfGr4JG5XhZo73ijTrCuzBViGx88=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-170-TQGwKYvwPdCRtp6xELBLCA-1; Wed, 16 Jul 2025 16:23:50 -0400
X-MC-Unique: TQGwKYvwPdCRtp6xELBLCA-1
X-Mimecast-MFC-AGG-ID: TQGwKYvwPdCRtp6xELBLCA_1752697430
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4ab752e0af7so5356111cf.3
        for <linux-rt-users@vger.kernel.org>; Wed, 16 Jul 2025 13:23:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752697430; x=1753302230;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mr/+do2GDPWhwVd6V8Vx9NSKkTbStmVd0u0erxRoPLA=;
        b=ob9NLJ0kPDy+Iqm/TlbJg1w32bEESa9TFWzRAEmvk+YIBtsZ0/zrRnA0pYHVjNb+3Y
         W79P+9xsKEls+S91VuR5+0LSGCYnz+oV+sITYH3f4tSRuTAGWB/cip47bjhJPOkMTkcg
         W+1OhAsJtQni/CBnMZDEgV7H01mkRQ3bODUzgZ1JtYdswQYkT/z75aVlshE8AegBK3tK
         KSjl/0m5X0HUocDaUxd5ORurCZEd/ne6AyfplZV9q1e9EfvBXdZ8y+Qy7tNPBat/qIui
         JUsx+yGPgHUgBHrb7IxExoWzMLrlTuVpCgez+fMtLkjDCxz2JeqLVc8+Cf2XEvFltMrm
         fpDA==
X-Forwarded-Encrypted: i=1; AJvYcCVqax6S9hSoR/VrPa0ZWHkyZBJdbK8biCLQqdFr/uCMZ2UuE8LUa0W/FjR9b7RE9KwGST1xpJJ0hkWtAavMNg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxtbYb+fxYALdxy4YI2vlBn+YkomBLOeJfsuC9hvzpnwQN7A23q
	PJyYSETuWyxguXHhVM9acj980BykdyvANV5EkX0fCuGdycrBYYnSoCV7fVr2l7ZXcquzrcvzrTi
	0GDRFCmalSs2cCW7Yrc04MGhZa2rBm8yhi+2VNvvVRElQnoX8w/L1PXMmB+drRtPsyqL3
X-Gm-Gg: ASbGncunzktAXAa8hZLr7oWrbPdv3ailaf4E6cFzQkEZrwLEQ5lERYZ3cB382nbawYK
	PvJWqdce0d08oHqhAtniBQbjVo5ZTpuf/Lto5wT+WxUmd3p43gL/NPE72QUhRXLhRP9WPEWTq9k
	MTxK4zj6QOBO+ZS6hGI0UCw8uGVkurKi82O/a750+T5CGQhvHs/osp9MLiyy+OfI/L7STcX6SDi
	NP1ulnY+Oz6kMUs5ZHYCK6f2tQU8TAO1Li6FoJeIWKZmMCUr6IgSkrljcQ+bYTCMoL4CPH7ckYz
	lPR9TzldeFdW8A9A9OOgbZ9rTzICNsEeuKQ=
X-Received: by 2002:ac8:7dc5:0:b0:4a5:a7a8:fd83 with SMTP id d75a77b69052e-4ab90c8f2ffmr65459851cf.44.1752697430208;
        Wed, 16 Jul 2025 13:23:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1xpUID2JeLLckyTAeaBzol4kFcLKjEsRVryY9A7nAEkMgS2rjTXOQoQxAsVR6XDZyH+27PA==
X-Received: by 2002:ac8:7dc5:0:b0:4a5:a7a8:fd83 with SMTP id d75a77b69052e-4ab90c8f2ffmr65459511cf.44.1752697429802;
        Wed, 16 Jul 2025 13:23:49 -0700 (PDT)
Received: from thinkpad2024 ([71.217.43.42])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ab5d41249bsm45114141cf.30.2025.07.16.13.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 13:23:49 -0700 (PDT)
From: "John B. Wyatt IV" <jwyatt@redhat.com>
To: "Clark Williams" <williams@redhat.com>,
	"John Kacur" <jkacur@redhat.com>
Cc: "John B. Wyatt IV" <jwyatt@redhat.com>,
	linux-rt-users@vger.kernel.org,
	kernel-rts-sst <kernel-rts-sst@redhat.com>,
	"John B. Wyatt IV" <sageofredondo@gmail.com>
Subject: [PATCH] tuna: Update man page with cpu_power command
Date: Wed, 16 Jul 2025 16:23:27 -0400
Message-ID: <20250716202329.520768-1-jwyatt@redhat.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[1] added support for the Python libcpupower bindings to control the
cpu power state. This patch documents those changes.

[1]
https://lore.kernel.org/linux-rt-users/20250409193136.44411-1-jwyatt@redhat.com/

Signed-off-by: John B. Wyatt IV <jwyatt@redhat.com>
Signed-off-by: John B. Wyatt IV <sageofredondo@gmail.com>
---
 docs/tuna.8 | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/docs/tuna.8 b/docs/tuna.8
index 2423894..6e30537 100644
--- a/docs/tuna.8
+++ b/docs/tuna.8
@@ -24,6 +24,24 @@ Log application details to file for given LOG-LEVEL
 Print DEBUG level logging details to console
 .SH "COMMANDS"
 .TP
+\fBtuna cpu_power\fR
+usage: tuna-cmd.py cpu_power [-h] (-c CPU-LIST)
+
+Set or query the idle (power) states of all or a selection of cpus in the CPU-LIST. Modifiers \fB\-c\fR may be used to pass the CPU-LIST of cpus to perform the command on.
+
+optional arguments:
+  -h, --help            show this help message and exit
+  -i, --idle-info       Print general idle information for the selected CPUs, including
+                        index values for IDLE-STATE.
+  -s, --status IDLE-STATE
+                        Print whether IDLE-STATE is enabled on the selected CPUs.
+  -d, --disable IDLE-STATE
+                        Disable IDLE-STATE on the selected CPUs.
+  -e, --enable IDLE-STATE
+                        Enable IDLE-STATE on the selected CPUs.
+  -c CPU-LIST, --cpus CPU-LIST
+                        CPU-LIST affected by commands
+.TP
 \fBtuna isolate\fR
 usage: tuna-cmd.py isolate [-h] (-c CPU-LIST | -S CPU-SOCKET-LIST | -N)
 
-- 
2.50.1

