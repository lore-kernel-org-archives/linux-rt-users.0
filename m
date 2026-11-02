Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793653097;
	b=i+IvdolWneTHzcAxLZJ41A8kWzjdsX9XURWU+/Hd/kIaOMoftd8R3YQgD7I3hluANVbd
	 dwDEj0zxDhw7ACigvTyPkClkAUlDGudjKtGZb/0JtTiyCc5RP5cLXuqn5ENFABT0mtjSg
	 S0zRrp67nOx19GeO52Ua3NMlJQcbCbNjWNcA5QUOdk/zwnIV/2atTg1/gxPrz0HkHZtew
	 Ng7t+Q3DsrokyiJ409K8B/4+8KUKLDhE4woxPFfM4zmUHZsFzawmuf5GUk+pv94XmRBXK
	 MXT+No58WYc8sZ2D0+msH5hquNxbaGcTo/Lvw0fB8MIQOQjhcRjdBis5PJ32UsuLJxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793653097;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Sender:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=Z+/ZiPDIvVzLUtv46l/6qBPlimBmIm937Y2zXqr1UM0=;
	b=fO7yONi2Oxkw5KJoGF5ji7/4AtAD2IbQYdbu69CdoXi8rKGU9FbAZg6oFIQXarONKhUi
	 10MHycO/OKQoBnm7B776TO1rE11p0lkyWTpMMG/it/cfOPxtUV4GlIk2mRLqe90Kruyos
	 4WvoDK/8WGjLQVsLMzK95AmqIPkv3BZY8/fFIUQkw75lLgLgn2LHOTz2rf7jjN+95fWL6
	 w3Oig6Rpv8Ziiu7J7GYKqfWu2AyEUrQwyRvxIRMeaJ7Ul+oebLuS+kObaOn5QEoN23x/T
	 tB7qNhh51BikI1BFMYauUeMTrbZA0t/nKgVOldQw1u7Sh4l7O+zvPySQ2u3MAHFd6qA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=redhat.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=amfDDmCJ;
	arc=none smtp.remote-ip=209.85.219.44
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE76A606A324
	for <linux-rt-users@vger.kernel.org>; Mon,  2 Nov 2026 20:58:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE76A606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=amfDDmCJ
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-91c847584b8so810886d6.0
        for <linux-rt-users@vger.kernel.org>; Mon, 02 Nov 2026 12:58:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793653096; x=1794257896; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Z+/ZiPDIvVzLUtv46l/6qBPlimBmIm937Y2zXqr1UM0=;
        b=amfDDmCJiW36BEh5LjntJpOu6pQgpaTIyOmBGgGHDCckzUnopYLyj2BFbpeiN0sHBO
         ITsOGJGWItgIY9UKIhC2ROnKT7xSHeRYRl3jvgJU0koOkQBgbYihWJUkGc2BsWuB5NRQ
         5FmAVgEOkKJwKtVjhQ4PqL2w9o7C7aJ+k9g7Yei5dRuBvLivc3XHGJ97T/nlIOiXC7AJ
         1ve3onsJLtJXFxZYcHhpag0I36xMZ5wsGiQrF89dP3goag5zU5BKagLRWxKuV7RYZdzS
         w9gBJZA9l9VqwsiksCExLpY9nuRz7BUdB7MedZyGy5uD6U21+NNVOxiL38frlQVLgNV6
         VNYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793653096; x=1794257896;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Z+/ZiPDIvVzLUtv46l/6qBPlimBmIm937Y2zXqr1UM0=;
        b=S53WKnZNbcnnpFexmH+Y9ZiNViD1OkUOUDdfMYmbHa4cQy84L4o8lblYx/bBp7+a72
         Kc/ZyfsnMNs7sqjwy1pOJiRU/OxCfTfMZH9M4kAi6nmtDo3bZAMefCS16Obkx3BF+wkw
         QxCvctJIsq839tjvVs6JGCvAXSiLclxeTjM2uWIBeX5jTbbTe2cJexbul84nH1973Dtt
         6CcCg4Zh6MQTILUszLkfZ2wW6JbrQY158cPsIdwN4Gfp+detMQ/fKMs1JJ+WolRx3y9+
         kRXFnnF4vZRuJn57hQqjeogtGZ8HzWbUz5YdaGmFqfuIPyqa/qma+IxVldnK0iAQk1GF
         qW3g==
X-Gm-Message-State: APuU4Z88UnJSCkeSbpExnUglsM9Hw0ELChEaoPGJyhS+UYSREL2Q0jpo
	Mwj5GFwSGzq/r2RykaEZg70tmaLmshnlipbCrdEZc/hdfFuhpJUGF1L3wG827g==
X-Gm-Gg: AYBFou0h7h8pGdFXRD7TZ/QpP6Mog+wcMoTlHE7oidZvin5edBcjBD4sD0SR7FF32dX
	7WKG3rT3LgA/sOssjgpEsFgvIvVXPdtn6AH60WJ3a7qLzd0uV/xkR/ciyk4pUVcOFz86ZkvF1uI
	dOZcFWEp531hcbgeC068HZwRUhxx1IID99dQ6ja1P6NVCjSee1YXhxuHiXrpFIKk8hws2i/y6g3
	qq9I5ehC7Eb4PVWkr30RicTohENkuKf5+OQFYC2xxeEA8VS68KKjgSWOr5a4O20LqmQsPfg9MWZ
	AKYsCBwCqiA4bL+Zh84c555CG3dphQo1SuP41BgDAneyeB89pibjM8lOmf+pRG2NCStWgNdb4bn
	5ijbZbQboWhix6aqroNs1bh14WWxDYk0GhQiEEi49eeu1pqFONxngmm5BfN1YsJFl7Wx0L+hq1P
	iTJe1JS1mDWGEnI+gxR7W0as0ZBB6K7XOQc234/vToDd5EjMB4JhaMHJyzcS5JoQSiaHz7M8gWg
	yZ02U/x8lPuSiMUEtjYqYKMbKx/0Jeb/5d4sbqs877Q4BJdwuzuxkVJhqhx5aOI6ticbzQxGYnz
	I7IeY0uEeO+K4U5vHaL0WvBNJ8N+cu9cG74FGvgP5Z//nmoVetghKCob56uhVnL0coZuLxzYkxG
	BrXUqmuC9Z/RKJVK3JTg8BxGER74rmNIc3WJHACxRvCGtDEgMQoBL/6SJqpbrOp+OWFniErqA92
	PwgydBmQqxQeDWA32vf8+d+kMdDiY=
X-Received: by 2002:a05:6214:2b88:b0:91c:6cca:8268 with SMTP id 6a1803df08f44-91c9088dc20mr223103486d6.33.1793653095610;
        Mon, 02 Nov 2026 12:58:15 -0800 (PST)
Received: from jkacur-thinkpadp1gen2.rmtcaon.csb (bras-base-toroon01zb3-grc-09-70-50-116-123.dsl.bell.ca. [70.50.116.123])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ca8068ca8sm100932756d6.36.2026.11.02.12.58.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 12:58:15 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-rt-users@vger.kernel.org,
	Daniel Wagner <wagi@monom.org>
Subject: Re: [PATCH rt-tests] rt-utils: Remove access to /sys/kernel/realtime
Date: Mon,  2 Nov 2026 15:58:10 -0500
Message-ID: <20261102205810.80572-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20260923131320.5zhWJFy0@linutronix.de>
References: <20260923131320.5zhWJFy0@linutronix.de>
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Post: <mailto:linux-rt-users@vger.kernel.org>
List-Help: <mailto:linux-rt-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rt-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 23 Sep 2026 at 15:13:20 +0200, Sebastian Andrzej Siewior wrote:
> rt-utils: Remove access to /sys/kernel/realtime

Reviewed-by: Daniel Wagner <wagi@monom.org>
Signed-off-by: John Kacur <jkacur@redhat.com>
