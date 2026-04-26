Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB3A3612F6
	for <linux-rt-users@vger.kernel.org>; Sun, 26 Apr 2026 14:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777212171; cv=pass; b=FZVtDNz9BuIgNtyapRwizH18LNTpJQLkc+COsFBKkZCCDEaMdRQYQpQ6TZvfSd8bZ3GJe40y2gxSsx38E4RanwLBNZlF2qkW1wL55AhUH3/9W7KrDFZaaBbPcGTgB1XxvqW+kSv8QEyYVasjSmgU+PQuQgOCe9aSzpHIn5FLRy4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777212171; c=relaxed/simple;
	bh=J+WG1epYf3FWs89SioxASIMCdjwqdpFMeRVJCq0YxLw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pNSK9+sskF4WUqDs+Fgj4BVpfdYtIeL3HPZuxyCsEiI9lrUcDcB8us2mXMdJmofpj+SwtTvjle2xINEQBqk4h7AfP3x7StxCViIRMCYA9B7vEWkYXdgAAmcoNEZGcmWPSds88IA55yyxUNfBHrYDopfUZJy4szmlO85P/M1bLJI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xbw7byoG; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Mr5vRyiG; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xbw7byoG";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mr5vRyiG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777212169;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZGX5oGm7k1Ym1M3BLEpD59EYEro3AcqPGoKu98xmmmY=;
	b=Xbw7byoGRky+53TJ772yrJJWREB2MClkju5Gq1y4wOv/GCsIrVMgvAriLujUHLhoeCrfd5
	023cpxDqEChZOSyhYC9TB5BQc51zoqyWHjkSO9CHJb93sKZN9oYBExJNJrwVEUjBdgYVby
	W9IHBpLgmO2VLAVKUBWHYCvhSzq7puk=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-389-Wu1bwX51Nlecepo-SHn47g-1; Sun, 26 Apr 2026 10:02:47 -0400
X-MC-Unique: Wu1bwX51Nlecepo-SHn47g-1
X-Mimecast-MFC-AGG-ID: Wu1bwX51Nlecepo-SHn47g_1777212167
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-676ba2a84b7so5573825a12.0
        for <linux-rt-users@vger.kernel.org>; Sun, 26 Apr 2026 07:02:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777212166; cv=none;
        d=google.com; s=arc-20240605;
        b=OsUusXNy9X/9AlVOW4l+Wpc38gHleqNwckWVZ7BEv1K4JwI0toQJqsyiKNBKOwulsc
         OpUrF8kkSCP4MdACC9LJiui9TWwgNr9/2xKBOdx3xLwCc2T4bhDa2s8YmeHrSh106EIQ
         45XoSsv9PX6UA9XrZLkmr4bXLfxbd0tmEhEzqJOAy9eKrrVwbv9B3jaEfdr7W49FpziZ
         tvsSoNFd//2clCCrUPu7hIqeeMO1mjSYLx2PEHAVojsAxWg4QZad4QPMKzah/Rssafei
         2TXGxXQUBHsFKxbmefzB5/elgY7iKXFuRAfEudC9bfE23dNBmvv+SR+45yV7NtFX4ZQe
         7Adw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ZGX5oGm7k1Ym1M3BLEpD59EYEro3AcqPGoKu98xmmmY=;
        fh=vINDFT+GIOgR3KhIwpxZgV9spNiD4/H1mUEmtEy5bMo=;
        b=ZakLfH2FmgzkdzJm1Wm9xirxxi8bpb44niNlUqdUR5maZ7VejBrHVeQBg4zUStpH6s
         3Fg2T1c/PbWZl6cZlYJh6XQut/FdO8A1vbneixfFzUUr0pJDa9uSJXYghpE5aiRwZdN2
         eEBzNxAabpB6ssTjTzfkgddwkmLdaV1mRMFe32a/VER52hFOInVh+C+nLAsb8dH/BRBT
         Mu8q8eNc6HUb5SxTVyRA267kB9Y1F0MjgPH1xJ+zgwGuSHdzoxsL4La00adEsLMPo+8+
         viYpQiEh+rVXCE1s01HjmbFW4ps0AvZQaIOGk7wudY1xtTZFKF5kRsAro9dg/9DS+JnY
         ZCYA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777212166; x=1777816966; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZGX5oGm7k1Ym1M3BLEpD59EYEro3AcqPGoKu98xmmmY=;
        b=Mr5vRyiG+1KQNYYc7kBWf1U/os/q23/mhQfFb4mJJpqafb1L0dABg3zKzy4HtojurM
         /UAH+DiqJHW8mEwGIy15Gp5pW8kHYIQluwh+2X7C6byGRvf8sIlAPxFMFU0BA+XWcuOR
         aia1PUjTxRIwMZRD22p0jvn5BUmsOZas6wZ6rnLDk/8217wbqdrZ32b8YCM93NDoNsEH
         eXk8c5uL0xkbYKvbWAcQYByvVPM826BPW7vUdhp23IaVeNw4uo3qCz45Ocym+A6cgcco
         EvD6HXEc/hAEb6QSzLsRTTIFnJST6lV88N4B5BJY4J0Gus8yT0IYF1lBDPTS3OiqTcGS
         pr9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777212166; x=1777816966;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZGX5oGm7k1Ym1M3BLEpD59EYEro3AcqPGoKu98xmmmY=;
        b=ZbFnnll1OfrXAHinbL0x/hReu/P1th1wLKdAef463Y5PUn24Q7cPaKBkORWkhzWHRQ
         mCFhfEITXwPnH/49e67g/f8OvlfWuaKqISmd55LYc+gC3AwPfYSxjOQazyDXCfULeZ15
         r/NakVYi43xHQiDWAWVjE9a0+HUk8tG59pHYkjXzycwb1eGgWdPMhm3tilAxII/d8xHh
         NqqHN3w81J+lF/XcymieIpkWSWdo0VOhitl8teNz7vc0PWfC0SuYWvdKAq+H41RBcNKU
         c1QevbyVtmURVwCOGBqDIQBtYKUHzN5u3Y8xEnuqCmynToB0VD1z+bcTD0kNFXCWwyK4
         YfQQ==
X-Gm-Message-State: AOJu0YwBK47Ijvp3Aw+Hzz0nTnrQpHmtC+6Mk1qk2NNopl0lxxDS4kH7
	y4b90tmLZ0/yQwWF8mPjKrs6rwudrZgbLaZvcvZM3FAOYpzyocNYDmJx2LIDBWOLz0vxmlWLVG6
	cz1bO9YV/DxiBcSuYt/q2btGbd9F7hJFK7SHS7RA+Gngzxff5zI0JjTcJu+HN0SSHJEcjTrAoWt
	gJuQt1/8ZpdsynapBp7BxlRqyGih8MslKqH2TdgxVTeVE=
X-Gm-Gg: AeBDiev9WP7SJXAJXyxjSYIef62hlCAwWqWE9nS6yYFQ/AIn8tugyM0k/lu8TgjL1/s
	qlejClB58pGeKsm3M6YXcs6yzl9rEBoLEIhaq1jDVPedoUicpLPd8UMqKeoyPEq/44HJfE2dvQU
	1Y250b/ttaRlME+DaC74lPwQ9eUspxgy/5V4PbNu4Vp0WV54KKI8w8876Rt5THlXFA/eD9pZGng
	Z165BFR2J5BfScz3XhOF+h9cSPTaK5ikVFfx0pE+oXQH6TcCw==
X-Received: by 2002:aa7:d713:0:b0:670:8d21:dab with SMTP id 4fb4d7f45d1cf-672bfddf0c0mr12334503a12.24.1777212166466;
        Sun, 26 Apr 2026 07:02:46 -0700 (PDT)
X-Received: by 2002:aa7:d713:0:b0:670:8d21:dab with SMTP id
 4fb4d7f45d1cf-672bfddf0c0mr12334499a12.24.1777212165982; Sun, 26 Apr 2026
 07:02:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260323160346.230639-1-costa.shul@redhat.com> <20260415192729.175250-1-jkacur@redhat.com>
In-Reply-To: <20260415192729.175250-1-jkacur@redhat.com>
From: Costa Shulyupin <costa.shul@redhat.com>
Date: Sun, 26 Apr 2026 17:02:08 +0300
X-Gm-Features: AVHnY4K6d-5SOLgBZzPr6G2agLPu6YcFu5HVhjX5ar58qori-tRAH0vG1z8hIHM
Message-ID: <CADDUTFxHz4RzJ_QzjiuHKGi0=U3u_C=Nuong+gRn+ZN1KFA9Sw@mail.gmail.com>
Subject: Re: [PATCH v1] rt-tests: hwlatdetect: Add --time-format argument
To: John Kacur <jkacur@redhat.com>
Cc: linux-rt-users@vger.kernel.org, 
	"Luis Claudio R . Goncalves" <lgoncalv@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 15 Apr 2026 at 22:28, John Kacur <jkacur@redhat.com> wrote:
> 2. There's no try/except around strftime(). If a user provides an invalid
>    format string, the code will crash. This should be handled gracefully.
Python's strftime doesn't crash on invalid format strings - unknown directives
like %Q are passed through literally. No try/except needed.

> 3. The use of a class variable for time_format is unconventional:
>
>        Tracer.Sample.time_format = args.time_format
>
>    While it works, this makes all Sample instances share state in a way that
>    could be surprising. Consider passing the format through instance
>    initialization or as a method parameter instead.
This surprises me. It's simpler to make `time_format` global or even
`args` itself.

Thank you,
Costa

