Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=comfiletech-com.20230601.gappssmtp.com header.i=@comfiletech-com.20230601.gappssmtp.com header.b="LdjZEiF6"
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0F2A83
	for <linux-rt-users@vger.kernel.org>; Mon, 11 Dec 2023 18:53:41 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id af79cd13be357-77f2dc3a9bcso320072385a.3
        for <linux-rt-users@vger.kernel.org>; Mon, 11 Dec 2023 18:53:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=comfiletech-com.20230601.gappssmtp.com; s=20230601; t=1702349620; x=1702954420; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:subject:from:to
         :content-language:reply-to:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M5AgKY0ltgVGWHMFOCDAdyXFOVgQEbJPGnEYdR2nvW0=;
        b=LdjZEiF6tkUqKXHCdVvg2cESk9ppSbllOgb+Xdf/X0wvGy/ve4gt8jr38n5N4ojif7
         OvgXqcqwimIekCnJGuULNPV6zA8DmficPptJIt5zIz1tFq33w0chKlCBUiBf/NplDB0q
         4QRnkKZ+NKaFX64OFYecmFjvsMj0wn4bck0rco3kuZMb3QjbZDoajF/lc2bTQtPieJ7z
         zUZa961hEUkYMTHTRinEfcSJulG6gTETM9IDO3A+rkvnc3QnSKYyUow3n9RDDYQ1mHYK
         6Q5eyq9QaETtbN1AfxPGhPjzExUR1dglmQfG09FTQyR8ehrwWu6Ha3Dnz+sbHeq8g3lW
         Mc2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702349620; x=1702954420;
        h=content-transfer-encoding:organization:subject:from:to
         :content-language:reply-to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M5AgKY0ltgVGWHMFOCDAdyXFOVgQEbJPGnEYdR2nvW0=;
        b=FzSxyWAVyf++QnIkXvpfPdb/Q+xvrD8XjWCBlFJjYSZ0BfqKNWUt6irtGCwv/ujVxF
         aR8k+rDyq6/qGmF5BMzfwbTNfa/+eIPWALxRPTEgCcTM+/gd2HjklQ0E26voDT9kxsRt
         lRez3XHRV/CzZYOAuYvOFQWUENb2ouAkB9AiWA2ofiQ+Ku7/W/UMv4L9VXcrb9UXZtmV
         ii7FdDNNfQdyUQbeMc1imsAJ3EvY0B0NXhtsllGkf0xDqf/Q127PhpwsimZoCGoZyjiN
         QMqRNvWU5oqq8XPbHvbNF7yltscL7A9+1AU7/WaAB5PGI49QdSvn/1H3y576Pe0ahp2R
         qDxA==
X-Gm-Message-State: AOJu0YwbYmgCk0RKvyP98NwVs5JghWYJtzwbETG6Dia/z9aiQPOYlkCZ
	YEgx3gb0pjy0BRcahk1HsSaeacWDZd3rj4BqLm8=
X-Google-Smtp-Source: AGHT+IGANuzmjWVYmRAPXZoB6MptK2iRXPQJcaTu/P1OnVCXbuFxUTH/iyup6ykuLg9zHJjZFgLmIQ==
X-Received: by 2002:a05:620a:111c:b0:77f:408d:1bab with SMTP id o28-20020a05620a111c00b0077f408d1babmr6238339qkk.22.1702349620569;
        Mon, 11 Dec 2023 18:53:40 -0800 (PST)
Received: from [192.168.0.11] ([115.94.64.218])
        by smtp.gmail.com with ESMTPSA id li3-20020a17090b48c300b00286a2cb70d1sm7846897pjb.5.2023.12.11.18.53.39
        for <linux-rt-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Dec 2023 18:53:40 -0800 (PST)
Message-ID: <44fb3d4d-6303-4287-b2ac-7898cc237c47@comfiletech.com>
Date: Tue, 12 Dec 2023 11:53:36 +0900
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: mfranklin@comfiletech.com
Content-Language: en-US
To: linux-rt-users@vger.kernel.org
From: Michael Franklin <mfranklin@comfiletech.com>
Subject: i2c jitter is worse in PREEMPT_RT kernel than stock Raspberry Pi
 kernel
Organization: COMFILE Technology
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello,

I'm experimenting with the realtime PREEMPT_RT patches on a Raspberry Pi 
4 and Raspberry Pi 5.  I'm using 6.1.66-rt19, but have also tested with 
the latest 6.7 kernel and RT patches.

In most of my experiments the realtime kernel improves jitter over the 
stock kernel, but I've discovered that when using i2c, the jitter is 
worse in the realtime kernel than the stock kernel.

It's a little difficult to describe, but can be seen quite clearly in 
this annotated video: 
https://comfiletechdownloads.z12.web.core.windows.net/RT_i2c_jitter.mp4

The only difference between the stock kernel and the realtime kernel is 
that full preemption is enabled in `menuconfig` for the realtime 
kernel.  The kernel is booted with `isolcpus=3` and the program is moved 
to core 3 with `task set -cp 3 $(pidof i2ctest)`.  Also the program is 
scheduled as SCHED_FIFO.

The i2c test program is very simple.  It is written in C/C++, and simply 
sends 2 bytes to an MCP23017 IO expander.  It is basically the following 
C++ pseudocode:

struct sched_param param;
param.sched_priority = 99;
if (sched_setscheduler(0, SCHED_FIFO, &param) != 0)
{
     perror("sched_setscheduler");
     return 1;
}

int fd = open("/dev/i2c-1");
unsigned char data[2];

while(1)
{
     struct i2c_msg messages[] =
     {
         {
             .addr = 0x20,
             .len = 2,
             .buf = data,
         },
     };

     struct i2c_rdwr_ioctl_data payload =
     {
         .msgs = messages,
         .nmsgs = sizeof(messages) / sizeof(messages[0]),
     };

     ioctl(fd, I2C_RDWR, &payload);

     // to avoid requiring `echo -1 > /proc/sys/kernel/sched_rt_runtime_us`
     std::this_thread::sleep_for(1us);
}

The communication works fine, but it's just too jittery in the reatltime 
kernel.

Interestingly, in the stock kernel, `htop` shows that most CPU activity 
is concentrated on core 3 (which is what I expected and preferred), 
while in the realtime kernel, the CPU activity is distributed across all 
cores, despite booting with `isolcpus=3` and running the test program 
with `task set -cp 3 $(pidof i2ctest)` in both kernels.

Q1:  Why is i2c communication is more jittery in the realtime kernel 
than the stock kernel?

Q2:  Why is activity distributed across all cores in the realtime 
kernel, but more concentrated on core 3 in the stock kernel?

Q3:  Is there anything that can be done, either via kernel 
configuration, boot parameters, or something else, that improve the 
jitter in the realtime kernel for this specific use case?

Thank you for your time and consideration,

Mike

