Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16FCA328B58
	for <linux-rt-users@vger.kernel.org>; Thu, 19 Feb 2026 21:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771536097; cv=none; b=NdUJWcYGyz0ZgXB+UjCB06cfS2ou+Ms4iDzzk8/5XwEp7VBsQVrX3kneZb2xRduJQ8/NwIQ9AeUz/4le8lVctCQf1lxbECBY+187GgzIrqX7/x6MmDYwZwDLW+rwEpLQRoIveuA5Oz8RTyW+KY4d8UqOHKQMrlVYF4kesZILACM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771536097; c=relaxed/simple;
	bh=SdRHOJv44D0bqIK80fxKL+hLEZGzm9fA4CJocFFoNqo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sa1PIPS2fYB1TnVvXEXTObya86MMxnbY9ka1IsdrpkmARc2vCktup5My8UbNCFljGRLg+IqAMjH/Y0syCj0o+w/JuiNj8dPOmGb73thcpAI16QmK2767nZx7UEq+KpqfUEAteciuNddvwYCAucu2h8AorNByItq630sP9J16zKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KK0QXhV7; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KK0QXhV7"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8cb39f64348so129021585a.0
        for <linux-rt-users@vger.kernel.org>; Thu, 19 Feb 2026 13:21:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771536094; x=1772140894; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/tMSc0xdtVsJUHn44yGbWg7fGE61f72fvNISagRaPMw=;
        b=KK0QXhV7RYW+53BTWftm1J6nRQbqOglIg5RovYaloy0jkV0Y5M4jlvLGugzmw5qX97
         qqx+Kdy684TXrpAQqOxpMDmrOUpVUECefg3olWq2nBCDstixl1GGXUc4T+MfIRQREfug
         hupSpjfl375RC9jDEgO8Z738NbgQYg+sQVBdKxyL6K7IzmrdQsS2Ney/EKU/WFqf+EMt
         5gaLYIQeF5QKCH6KWbfSrhqGxlV+enkZvwkVJc8q5DH/Ps1iO7FyYY1bsvNaL32vCVPu
         4tQT2DuxJIyGGr10vmKVTxkBSCI8HDblGS1vOcu/PZJBU5I621rtziFmbbdFGzhXxOqe
         Ky8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771536094; x=1772140894;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/tMSc0xdtVsJUHn44yGbWg7fGE61f72fvNISagRaPMw=;
        b=A+KN86HJVmuaKZOstoa3/DbOlLaWMBk5zQxmQ0ecLugYjlPTPuWrhu4SUcy6clHwvF
         XxYkQN3ifyPnWViO+JTCcvM5qv7p0eZkf+3y3ryrsgrT0gNDv2zrRpDYHc7PExyffC5J
         4uoK4LxU8hgjEY5J6mocloW/LuTan7/4kc0KbcCq5x75H/UxBwjPlCbwPsLJqSV04xxa
         RJYzCBNj7kaye2F0ro+qJTSwk20J4B+tMD9wIAhLby0tSg4mAThGnqRTWOHFdnCaNbLA
         wCdJkALT+LRlUjLg5iDjYSLMXlvHeucMGTZBx/LrgKBcyg71VnKQlCILVjpx4n1oQllL
         F4aw==
X-Gm-Message-State: AOJu0YwzMAm8QzFptLImI2M3feuj7Kvjwn3DanLrFnAaql5W+UXFZgIa
	dighkg02iVkY2ZsLp0AO+kjkZz1sAYjjBrXDFzct6URQc6d1pUZqesr2tMU3M7Te
X-Gm-Gg: AZuq6aICKKWC5ue9f+pDUB1w0L80IOgmEgdveizOKyyxeSWdEhxe4yGizJTv5S0/z8K
	4AdFkEzPcrtNoMdgTPqvmapiZPCxj2qG2uoj6XWlgrpn0EHtYETEVr/aINFSaWeUd0JSYDuhoqy
	OBrhb+m65SGspTx7RmjDRTt/DIYJybcwaqVirf34bSV8cG9ExHR838E/bLqoyLuCtZ9ewWbdOsq
	X9CKgFSAgqYl2ElGd7S3DfPpJpaTLfwtI1Uq5+GrhHmCErqQa3yQfMLU4CvSkFbtgoaC/Q8cqIi
	QC9lWkbP5DdM8N+rADnkmnngVIXk7IhpuTnsTw3hj7hPdCc+NhhGCvEnWQgjKEasdOuU+pzdKs4
	t2luOe2LzmdVPX/4noTHvGk0C5Q4oQBy64I1pGajSrydthbkjaKrc8ePTOHPuTr3R9UmRx9TWGN
	ulDRh6DE15aWAV4mNHahHC08JTEbWYdn2GBB4fYTPQ37+9Z9hg/Aol5kTYhgG/pOo3a/h63Y6/+
	Tz5N1alU5+twE46Kw==
X-Received: by 2002:a05:620a:4547:b0:8c6:a2f2:d874 with SMTP id af79cd13be357-8cb40880133mr2785543785a.39.1771536094533;
        Thu, 19 Feb 2026 13:21:34 -0800 (PST)
Received: from Cumhall.redhat.com ([142.189.59.50])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cb2b0be6besm2142975685a.5.2026.02.19.13.21.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 13:21:33 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Cc: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>
Subject: [PATCH 5/5] rt-tests: cyclictest: Remove duplicate option in getopt string
Date: Thu, 19 Feb 2026 16:21:20 -0500
Message-ID: <20260219212120.227106-3-jkacur@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260219212120.227106-1-jkacur@redhat.com>
References: <20260219212120.227106-1-jkacur@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the duplicate -D in the getopt string

Reported-by: Costa Shulyupin <costa.shul@redhat.com>
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/cyclictest/cyclictest.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index b4bce8915b43..191945e1e0db 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -1147,7 +1147,7 @@ static void process_options(int argc, char *argv[], int max_cpus)
 			{"deepest-idle-state", required_argument,	NULL, OPT_DEEPEST_IDLE_STATE },
 			{NULL, 0, NULL, 0 },
 		};
-		int c = getopt_long(argc, argv, "a::A::b:c:d:D:F:h:H:i:l:MNo:p:mqrRsSt::uvD:x",
+		int c = getopt_long(argc, argv, "a::A::b:c:d:D:F:h:H:i:l:MNo:p:mqrRsSt::uvx",
 				    long_options, &option_index);
 		if (c == -1)
 			break;
-- 
2.53.0

