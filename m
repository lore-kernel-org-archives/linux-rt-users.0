Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360C03596C
	for <linux-rt-users@vger.kernel.org>; Tue,  7 Jan 2025 22:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736287366; cv=none; b=coyQeKX3TtnHxvGJ9ab2wfSdFedRhP39epeF2N+BC9kUjZZKGhQyj+QTsHq2AmmCCq0WAMxtNikZNZ2KCrfqH4zCkrKJdjkcNpo+wmE5SqnvDO2FEVN2UzwGspWUiYJ+dMVH6dzet6pmetCrgdHNsxE6435mTT4/eiTTo2APt4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736287366; c=relaxed/simple;
	bh=4i4Z9R5XCF8jgkOApqDnWleGXBvKIncf38S7dne9vSk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WcVCDimxBl9O57JoRRACSt/mJSO6h/QKI+RK6HWCKOTUwELYBeWzvoscgRsFVCgyXzlz1jfbqUIJKLcH740PsxA/1zsaPLTDyftCAB0qe28ZMp/NAz1vRdJGsqZcu+h6qUO8x5z+ReQ7R+bewjdb1kjU8wI2q2S8BgkiiUC3udw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G2n9C1RA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G2n9C1RA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736287363;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=woOeh0OqNuAIcJTTAVafTJw0IaURCPmTFY0QIPEcjBg=;
	b=G2n9C1RAghuLIa4DTgedVfl0CZHAc0xcQ9tB8Qtn9Gw5a0n6ErBtSTrXaRNQSxOd/GP6dB
	YUL7wVrLHLEwabAbi7ckzoTsh8uZWtnK2U83i/wQXbGBspt2VBuORxGJpxYpDLA3iNi2zi
	theLoQDXVNiHyJnGPU2KzYXJGp4xkJc=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-357-_Qjt-drAPN6zLOjRDJja-w-1; Tue, 07 Jan 2025 17:02:39 -0500
X-MC-Unique: _Qjt-drAPN6zLOjRDJja-w-1
X-Mimecast-MFC-AGG-ID: _Qjt-drAPN6zLOjRDJja-w
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-467c08e67easo323423171cf.1
        for <linux-rt-users@vger.kernel.org>; Tue, 07 Jan 2025 14:02:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736287359; x=1736892159;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=woOeh0OqNuAIcJTTAVafTJw0IaURCPmTFY0QIPEcjBg=;
        b=XizJhma5LSz7mjNnDESspRYpXn7mpJpcgrzlAUXQ0UyIDpPqkcJtmhVo9L7sOC2TFJ
         QI+Xi7Pr2K7ta/5tcAngPc6ucB/lXDZ00f6QlMjGOE6u2oJ7ylwGZmBUXDzHac7SnAJR
         ERcBj+ScYeMqcxMtv1eBznn7xj7TM0TLJMC7s0uDsmYqCxIabieOxXo/O0p1zIZo40OW
         OMY3QeiZ+8Y7L97iPAmfGni/T892KujhXsT2p58Z1TEm+elATK7wIm9452CSCfdc9HnA
         1x8I//yZ/RJvkFfp+dfmjoFvhUJRGsFJofSdKt30+uLemxHQFKrJcBe7pCvVs7vppgvI
         ZXUQ==
X-Gm-Message-State: AOJu0YyK4U5rSYvDQ3tEZ46QUA8cPm+87GYtCFsirQuhTiybzG2QlKxl
	xfw2YVZmq9D532P+uu/joc8PE1QvG1k1eFiPcZOFEJipI4HUZpLiQi6Vv6fkliJViUSmzXX2w1W
	F1VnabGjYfSvcOBzQ199GtCheyidtpYETN7o++BTLRdc7r8FwbSCdK8cnjC8GnPzf
X-Gm-Gg: ASbGncuPtdQBEC4VbV6bk7gz6rWyyXvsWyjYq9sufdzt64FVgaZQWny5kIq0lHtXe4K
	AdES3hejoKUZxh4jsSXvXFjZ8fI+/9Yoep/VcOE7uhWLjtvZC5PuW1HODlbzQ5zc6Ad4QoXcJpt
	Yl69A3yiagUIQEsHThkm9v8X0t73nUNBmTP2H7GehAkrXNfjxoLPIhzbJ+DBH89j/VlxKvZ1ZOL
	csuevABUc8CvkyTtkurK1qXPEOi3ZaW2lcZP+OY4e7mZ2aOVLKRBViLEw9OUlA8ZstrpcZDejO4
	kA/82zY06i9iCb68Dfp4f/erGB3l/ffHBS8wbaETXprBHw==
X-Received: by 2002:a05:622a:1a0d:b0:466:99a9:c354 with SMTP id d75a77b69052e-46c71005c9emr9093271cf.22.1736287359285;
        Tue, 07 Jan 2025 14:02:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFW++rskcKSRGENRu3zZK7afIOdRsLBhliPfK46sptIjE5NDt0JSrLElVTbh7aPCyXBNVRcbQ==
X-Received: by 2002:a05:622a:1a0d:b0:466:99a9:c354 with SMTP id d75a77b69052e-46c71005c9emr9092851cf.22.1736287358912;
        Tue, 07 Jan 2025 14:02:38 -0800 (PST)
Received: from crwood-thinkpadp16vgen1.minnmso.csb (syn-050-074-019-099.biz.spectrum.com. [50.74.19.99])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46a3e6ada4fsm189884261cf.52.2025.01.07.14.02.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 14:02:38 -0800 (PST)
From: Crystal Wood <crwood@redhat.com>
To: John Kacur <jkacur@redhat.com>
Cc: linux-rt-users@vger.kernel.org,
	Clark Williams <williams@redhat.com>,
	Crystal Wood <crwood@redhat.com>
Subject: [PATCH 1/3] rt-tests: Turn off -Wunused-parameter
Date: Tue,  7 Jan 2025 17:02:27 -0500
Message-ID: <20250107220229.156201-2-crwood@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250107220229.156201-1-crwood@redhat.com>
References: <20250107220229.156201-1-crwood@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

-Wunused-parameter (part of -Wextra) is an obnoxious warning as it flags
perfectly reasonable code that takes unneeded parameters in order to
comply with a function pointer interface, or where the parameter is used
only by code inside an ifdef, etc.  This results in numerous annotations
just to shut the compiler up, all for a warning that has relatively
little value even in cases where it's not a false positive (where it's
just an indication that cleanup is warranted).

Signed-off-by: Crystal Wood <crwood@redhat.com>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 0fa0928..dda29c3 100644
--- a/Makefile
+++ b/Makefile
@@ -33,7 +33,7 @@ prefix  ?= /usr/local
 bindir  ?= $(prefix)/bin
 mandir	?= $(prefix)/share/man
 
-CFLAGS ?= -Wall -Wno-nonnull -Wextra -Wno-sign-compare
+CFLAGS ?= -Wall -Wno-nonnull -Wextra -Wno-sign-compare -Wno-unused-parameter
 CPPFLAGS += -D_GNU_SOURCE -Isrc/include
 LDFLAGS ?=
 
-- 
2.47.1

