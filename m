Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86EBA33A014
	for <linux-rt-users@vger.kernel.org>; Fri,  7 Nov 2025 18:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762540032; cv=none; b=MxZ2R+NfDeXXRhdkZXoxB+F/TURPRb4TCsnhiNGndyyf+hq85PLRgDevMsqkoURGa0Ye+kIXrekRjVtzyB7RLxg5241zarG0Z5GbipRexgUe7rhbeeru+XoonPu/hxRo7BfBFer35JZ6cmm/eypfnLpxs36PcqEcIGOfvVeokcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762540032; c=relaxed/simple;
	bh=BtUDYljaqsTrHrMc9A71Fbm7buoZRlRXmRt8EaQN/dc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZF0C4o+GXwIjUVj8ohDk1h9SvS94Pd/H7n+2m0jCO+z9Mz+Q30Aj8+VS69hEAnC3mAZ/zhr+bp0XtgJ+9/a3CbzNtt4BbA/K+qavMbqvcY2EjANm5RLb89Fw7Y9XESwT1WW83FAaImowCg4M+X0C7D+RWUFLkCnq0AmROW6k5d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nBXEwx0t; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nBXEwx0t"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-88f239686f2so88118685a.0
        for <linux-rt-users@vger.kernel.org>; Fri, 07 Nov 2025 10:27:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762540029; x=1763144829; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yF6jfdQyKnCpPk0t2+CMb2xkCzs9iJrRJp30uqsznb8=;
        b=nBXEwx0t9pApjJAXssyd72GdHJPQvTZr3xDUdMotg0tRIyrLXe9WgpO1DayZJPyrOT
         P6ZGQMptd4fXwF9MgNrfEhQyYcuBcE6//Q9W0hho5vqzGy4TVq9UTSU/XLIJscbFm0Be
         TYrcVkGTbaj15X98og6wBjkVijKp/udJ/BAG2y6mRiFtfsMKyuhnFtG243jrALy1Pdzr
         GhsncLn4HwwF3b6adAY7PcgTluXpzYfZwjIL3A+SyAxB6vnt5vrssioyeQEognpwgrXd
         zZBHnCSziKJVCDuHQehukpwI5J7gimRhL2ESKlFlsPSSOzcq04kuVXtgy5PAW7wb+tUQ
         9zsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762540029; x=1763144829;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yF6jfdQyKnCpPk0t2+CMb2xkCzs9iJrRJp30uqsznb8=;
        b=PaFd2BxNC38hmeIGiCd6iTcFmAg8NG+KzBvqIcYHQSTWPj4J964wy5A4CrjqRZ+L+l
         s4LQJ+cwmILLWRHsD0kASy5Bmg8bb5Onh8zHvOzVac1fkGTLcKFe93KtYtj35/eYAwL4
         2VS2pIdscwMogcNHOn8EhSsdtaXjHWstlOB64j3z2mP69SqM+b9bTiABuKs6+k0/r5Eh
         isLF8wgy9NSDAMJTGigCnMGXCDlsO80Wji1+FRTc13Uj+iCoVNtea/AumHZM+/8oU1sL
         GuJhCssER0iYhAxvCq3oyERR+qkk6fxcRLu9+2HSDX7wCQCQgIOh9Ox/DknUTRa3Ofdo
         2u+A==
X-Gm-Message-State: AOJu0Yxi5GWluxxf8/pUoGrKs1f02l1BK3FdJjWto+jSY6ZtDPK4iVsk
	3E6HL5jdp6Ez4h0yejHr+gUvZ1xXdDCjSsjc24ZAPWqOcAvTfmV4R2+disJMd03B
X-Gm-Gg: ASbGncvkAav1vTFVS9Jd5KcEnLilQiOQaQ2VgXwDk6odbc/DkrH8DN3Fgm66JWOXkOc
	KDDx535BygIB9NJaGb1oLsbxtrEr1Ke2PmEez/7jUJGm09WwoM86Fw323KED9H5QKyBUnwOSO8A
	yH/PMGvxqasSluZ6f72SK5ybXiR1nfhF11Mb1OJKvsPJQHtmDsJPkOugasgEyFLNy0xM4NLSWLV
	Q+TajaHB0OJ3MKQZj9KKxGXrFoxkHPChFk4+X8xGET/GlGAGNIgAhjg/INKzfI48bWhNYuXF7MW
	fhMZGuXPMlOlZoIX5dkdE7fiquq5LGpIsNPePKhysAY60n0IgCGEB7BS+/z3KqmnXI4KWj9RnTQ
	Dx538tkSK34P+/VYslb6fyQXflh3YHb5Zv5Sg+H2kFltPR0WfpDtUc5f0lrfZpng=
X-Google-Smtp-Source: AGHT+IFvrVzZw8WstbL+27JBnRFMSUpHpauK9hxjy6AhUn3mIlN6O0UTJrykvS1i6IOcEiNza1aIYw==
X-Received: by 2002:a05:620a:1913:b0:8b1:be0f:da61 with SMTP id af79cd13be357-8b257ede481mr31796485a.18.1762540029045;
        Fri, 07 Nov 2025 10:27:09 -0800 (PST)
Received: from fionn ([174.88.40.44])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b235828514sm452141085a.53.2025.11.07.10.27.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 10:27:08 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Cc: Clark Williams <williams@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: [PATCH 03/12] rteval: Remove unused function remove_offline
Date: Fri,  7 Nov 2025 13:26:26 -0500
Message-ID: <20251107182645.19545-4-jkacur@redhat.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251107182645.19545-1-jkacur@redhat.com>
References: <20251107182645.19545-1-jkacur@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove unused function remove_offline()

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 rteval-cmd | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/rteval-cmd b/rteval-cmd
index b936ade23d86..7af179321fe2 100755
--- a/rteval-cmd
+++ b/rteval-cmd
@@ -207,13 +207,6 @@ def parse_options(cfg, parser, cmdargs):
 
     return cmd_args
 
-def remove_offline(cpulist):
-    """ return cpulist in collapsed compressed form with only online cpus """
-    tmplist = expand_cpulist(cpulist)
-    tmplist = SysTopology().online_cpulist(tmplist)
-    return collapse_cpulist(tmplist)
-
-
 if __name__ == '__main__':
     from rteval.sysinfo import dmi
 
-- 
2.51.1

