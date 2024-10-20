import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { DatabaseModule } from './database/database'
import { VpasController } from './dms/controllers/vpa';
import { VpasService } from './dms/services/getVpas.services';
import { VpasQueryService } from './dms/queries/get_vpas_queries'; 
import { ConfigModule } from '@nestjs/config';

@Module({
  imports: [
    ConfigModule.forRoot({
      isGlobal: true,
    }),
   DatabaseModule], 
    controllers: [AppController,VpasController],
  providers: [AppService,VpasService, VpasQueryService],
})
export class AppModule {}
